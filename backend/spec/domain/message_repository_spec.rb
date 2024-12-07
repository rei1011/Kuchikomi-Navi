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

      context 'メッセージが非表示の場合' do
        let!(:message4) do
          travel_to Time.zone.local(2024, 11, 24, 11, 23, 0) do
            create(:message, room_id:, is_show: false)
          end
        end

        it '非表示のメッセージは取得できない' do
          is_expected.to eq([message1, message2, message3])
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

  describe 'メッセージを作成する' do
    let(:room) { create(:room, :with_store) }
    let(:room_id) { room.id }
    let(:new_message) { 'おすすめのお店を教えて' }

    context 'メッセージを作成できること' do
      it 'ユーザーのメッセージとclaudeからのレスポンスが保存されること' do
        described_class.create(room_id, new_message, true)
        expect(Message.last.value).to eq(new_message)
      end
    end
  end
end
