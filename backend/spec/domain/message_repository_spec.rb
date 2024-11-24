# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageRepository do # rubocop:disable Metrics/BlockLength
  describe 'ルームIDでメッセージを検索する' do # rubocop:disable Metrics/BlockLength
    subject { described_class.find_by_room_id(room_id) }

    context 'ルームIDに紐づくメッセージが存在する場合' do # rubocop:disable Metrics/BlockLength
      before do
        create(:room, id: 1)
        create(:message, room_id: 1)
      end
      let!(:message1) do
        travel_to Time.zone.local(2024, 11, 24, 11, 20, 0) do
          create(:message)
        end
      end
      let(:room_id) { message1.room_id }

      let!(:message2) do
        travel_to Time.zone.local(2024, 11, 24, 11, 21, 0) do
          create(:message, room_id:)
        end
      end
      let!(:message3) do
        travel_to Time.zone.local(2024, 11, 24, 11, 22, 0) do
          create(:message, room_id:)
        end
      end

      it 'IDに紐づくメッセージが投稿日時の昇順で取得できる' do
        is_expected.to eq([message1, message2, message3])
      end

      context 'create_atが同じmessageが存在する場合' do
        let!(:message4) do
          travel_to Time.zone.local(2024, 11, 24, 11, 22, 0) do
            create(:message, room_id:)
          end
        end

        it 'メッセージIDの昇順で取得できる' do
          is_expected.to eq([message1, message2, message3, message4])
        end
      end
    end

    context 'ルームIDに紐づくメッセージが存在しない場合' do
      let!(:message) { create(:message) }
      let(:room_id) { 2 }
      it '空の配列が返却される' do
        is_expected.to eq([])
      end
    end
  end

  describe 'メッセージを作成する' do # rubocop:disable Metrics/BlockLength
    let(:stores) { [create(:store)] }
    let(:room) { create(:room, :with_store) }
    let(:room_id) { room.id }
    let(:new_message) { 'おすすめのお店を教えて' }

    context 'claudeから正常にレスポンスが返却された場合' do # rubocop:disable Metrics/BlockLength
      let!(:stub_connection) do
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.post('/v1/messages') do
              [200, {}, JSON.generate(
                { 'id' => 'msg_01HdqgBDvbTi3jP4HZKSzRfv',
                  'type' => 'message',
                  'role' => 'assistant',
                  'model' => 'claude-3-haiku-20240307',
                  'content' => [{ 'type' => 'text',
                                  'text' => 'CCCATS' }],
                  'stop_reason' => 'end_turn',
                  'stop_sequence' => nil,
                  'usage' => { 'input_tokens' => 27, 'output_tokens' => 331 } }
              )]
            end
          end
        end
      end

      before do
        allow(described_class).to receive(:connection).and_return(stub_connection)
      end

      context 'ルームIDに紐づく既存のメッセージが存在しない場合' do
        let(:old_message) { [] }
        it '店舗情報が付与されたユーザーのメッセージとclaudeからのレスポンスが保存されること' do
          described_class.create(stores, room_id, new_message, old_message)
          expect(Message.first.value).to eq("#{new_message}#{stores}")
          expect(Message.last.value).to eq('CCCATS')
        end
      end

      context 'ルームIDに紐づく既存のメッセージが存在する場合' do
        let(:old_message) { [create(:message)] }
        it '店舗情報が付与されていないユーザーのメッセージとclaudeからのレスポンスが保存されること' do
          described_class.create(stores, room_id, new_message, old_message)
          expect(Message.second.value).to eq(new_message)
          expect(Message.last.value).to eq('CCCATS')
        end
      end
    end

    context 'claudeでエラーが発生した場合' do
      let(:old_message) { [create(:message)] }
      let!(:stub_connection) do
        Faraday.new do |conn|
          conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
            stub.post('/v1/messages') { raise Faraday::ClientError, 'Client error' }
          end
        end
      end

      before do
        allow(described_class).to receive(:connection).and_return(stub_connection)
      end

      it 'ユーザーのメッセージのみ保存されること' do
        described_class.create(stores, room_id, new_message, old_message)
        expect(Message.second.value).to eq(new_message)
      end
    end
  end
end
