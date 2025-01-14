# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/rooms', type: :request do # rubocop:disable Metrics/BlockLength
  path '/rooms' do # rubocop:disable Metrics/BlockLength
    get 'Get Rooms' do # rubocop:disable Metrics/BlockLength
      before do
        allow(RoomService).to receive(:find).and_return(
          [create(:room, :with_store)]
        )
      end
      tags 'Rooms'
      produces 'application/json'
      response '200', 'room list' do
        schema type: :object,
               additionalProperties: false,
               properties: {
                 list: { type: :array,
                         items: {
                           type: :object,
                           additionalProperties: false,
                           properties: {
                             id: { type: :number },
                             user_id: { type: :number },
                             name: { type: :string, nullable: true },
                             created_at: { type: :string },
                             updated_at: { type: :string },
                             store1_id: { type: :number, nullable: true },
                             store2_id: { type: :number, nullable: true }
                           },
                           required: %i[id user_id name created_at updated_at store1_id store2_id]
                         } }
               },
               required: %i[list]
        run_test!
      end
    end

    post 'Create Room' do # rubocop:disable Metrics/BlockLength
      before do
        allow(RoomService).to receive(:create).and_return(
          create(:room)
        )
      end
      tags 'Rooms'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user_id, in: :body, required: true, schema: {
        type: :object,
        additionalProperties: false,
        properties: {
          user_id: { type: :number }
        },
        required: %i[user_id]
      }
      response '200', 'room created' do
        let(:user_id) { { user_id: 1 } }
        schema type: :object,
               additionalProperties: false,
               properties: {
                 id: { type: :number }
               },
               required: %i[id]
        run_test!
      end
    end
  end

  path '/rooms/{room_id}' do # rubocop:disable Metrics/BlockLength
    get 'Get Room' do # rubocop:disable Metrics/BlockLength
      before do
        allow(RoomService).to receive(:find_by_id).and_return(
          create(:room)
        )
      end
      tags 'Rooms'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :room_id, in: :path, type: :string
      response '200', 'room found' do
        let(:room_id) { create(:room).id }
        schema type: :object,
               additionalProperties: false,
               properties: {
                 id: { type: :number },
                 name: { type: :string, nullable: true },
                 store1: {
                   type: :object,
                   additionalProperties: false,
                   properties: { id: { type: :number }, name: { type: :string } },
                   required: %w[id name]
                 },
                 store2: {
                   type: :object,
                   additionalProperties: false,
                   properties: { id: { type: :number }, name: { type: :string } },
                   required: %w[id name]
                 }
               },
               required: %i[id name]
        run_test!
      end
    end

    patch 'Update Room' do
      before do
        allow(RoomService).to receive(:update).and_return(
          nil
        )
      end
      tags 'Rooms'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :room_id, in: :path, type: :string
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        additionalProperties: false,
        properties: {
          name: { type: :string, nullable: true },
          store1_id: { type: :number, nullable: true },
          store2_id: { type: :number, nullable: true }
        },
        required: %w[name store1_id store2_id]
      }
      response '200', 'room updated' do
        let(:room_id) { create(:room).id }
        let(:body) { { name: 'test', store1_id: 1, store2_id: 2 } }
        run_test!
      end
    end

    delete 'Delete Room' do
      before do
        allow(RoomService).to receive(:delete).and_return(
          nil
        )
      end
      tags 'Rooms'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :room_id, in: :path, type: :string
      response '200', 'room updated' do
        let(:room_id) { SecureRandom.uuid }
        run_test!
      end
    end
  end
end
