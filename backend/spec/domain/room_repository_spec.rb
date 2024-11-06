# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomRepository do
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
