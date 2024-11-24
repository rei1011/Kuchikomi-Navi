# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'messages', type: :request do # rubocop:disable Metrics/BlockLength
  path '/rooms/{room_id}/messages' do # rubocop:disable Metrics/BlockLength
    get 'Get Messages' do
      before do
        allow(MessageService).to receive(:find).and_return([{ id: 1, value: 'おすすめのお店を教えて', role: 'assistant' }])
      end
      tags 'Messages'
      consumes 'application/json'
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

        run_test!
      end
    end

    post 'Create a message' do
      before do
        allow(MessageService).to receive(:create).and_return(nil)
      end
      tags 'Messages'
      consumes 'application/json'
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        additionalProperties: false,
        properties: {
          message: { type: :string }
        },
        required: %w[message]
      }
      parameter name: :room_id, in: :path, type: :string
      produces 'application/json'
      response '200', 'get messages' do
        let(:room_id) { create(:room).id }

        run_test!
      end
    end
  end
end
