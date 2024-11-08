# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoomService' do
  context 'find' do
    let(:room) { build(:room) }

    before do
      allow(RoomRepository).to receive(:find_by_user_id).and_return(room)
    end

    it 'user_idで検索できる' do
      user_id = '1'
      rooms = RoomService.find(user_id)
      expect(rooms).to eq(room)
    end
  end

  context 'create' do
    let(:room) { build(:room) }

    before do
      allow(RoomRepository).to receive(:create).and_return(room)
    end

    it 'roomを作成できる' do
      user = create(:user)
      room = RoomService.create(user.id)
      expect(room).to eq(room)
    end
  end
end
