# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'messages', type: :request do # rubocop:disable Metrics/BlockLength
  before do
    allow(MessageService).to receive(:find).and_return([{ id: 1, value: 'おすすめのお店を教えて', role: 'assistant' }])
  end

  path '/rooms/{room_id}/messages' do # rubocop:disable Metrics/BlockLength
    get 'Get Messages' do
      tags 'Messages'
      consumes 'application/json'
      parameter name: :stores, in: :query, type: :array, items: { type: :string }, required: true
      parameter name: :message, in: :query, type: :string, required: true
      parameter name: :room_id, in: :path, type: :string
      produces 'application/json'
      response '200', 'get messages' do
        schema type: :array,
               items: {
                 type: :object,
                 additionalProperties: false,
                 properties: {
                   id: { type: :integer },
                   value: { type: :string },
                   role: { type: :string, enum: %w[user assistant] }
                 },
                 required: %i[id value role]
               }
        let(:room_id) { create(:room).id }
        let(:stores) { [1, 2] }
        let(:room_id) { 1 }
        let(:message) { 'おすすめのお店を教えて' }

        run_test!
      end
    end
  end
end
