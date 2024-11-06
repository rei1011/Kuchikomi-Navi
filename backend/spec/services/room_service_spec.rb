# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoomService' do
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
