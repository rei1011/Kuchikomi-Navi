# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomSerializer do
  context 'storeがある場合' do
    let(:room) { create(:room, :with_store) }
    it 'storeが返却される' do
      result = described_class.render_as_hash(room)
      expect(result[:store1]).to be_present
      expect(result[:store2]).to be_present
    end
  end

  context 'storeが無い場合' do
    let(:room) { create(:room) }
    it 'storeがnullで返却される' do
      result = described_class.render_as_hash(room)
      expect(result[:store1]).to be_nil
      expect(result[:store2]).to be_nil
    end
  end
end
