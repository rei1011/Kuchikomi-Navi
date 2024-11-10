# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomRepository do # rubocop:disable Metrics/BlockLength
  context 'find_by_user_id' do
    context 'チャットルームが複数ある時' do
      it '特定のユーザーのチャットルームだけ取得できる' do
        room = create(:room)
        create(:room, user: create(:user, id: 2))
        result = RoomRepository.find_by_user_id(room.user_id)
        expect(result).to eq [room]
      end
    end

    context 'チャットルームが1つもない時' do
      it '空の配列を返す' do
        result = RoomRepository.find_by_user_id(1)
        expect(result).to eq []
      end
    end
  end

  context 'create' do
    it 'チャットルームを作成する' do
      user = create(:user)
      result = RoomRepository.create(user.id)
      expect(result).to be_persisted
    end
  end

  context 'update' do
    let(:user) { create(:user) }
    let(:store1) { create(:store) }
    let(:store2) { create(:store) }
    before do
      RoomRepository.create(user.id)
    end

    it 'チャットルームの情報を更新できること' do
      # 店舗IDが保存されていないことを確認
      target_room = RoomRepository.find_by_user_id(user.id).first
      expect(target_room.store1_id).to eq nil
      expect(target_room.store2_id).to eq nil

      # 店舗IDを更新
      updated_room = Room.new do |r|
        r.id = target_room.id
        r.user_id = target_room.user_id
        r.store1_id = store1.id
        r.store2_id = store2.id
      end
      RoomRepository.update(updated_room)

      # 更新されたことを確認
      result = RoomRepository.find_by_user_id(user.id).first
      expect(result.store1_id).to eq store1.id
      expect(result.store2_id).to eq store2.id
    end
  end
end
