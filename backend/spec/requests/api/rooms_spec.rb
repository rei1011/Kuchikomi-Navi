# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/rooms', type: :request do # rubocop:disable Metrics/BlockLength
  path '/rooms' do # rubocop:disable Metrics/BlockLength
    get 'Get Rooms' do
      before do
        allow(RoomService).to receive(:find).and_return(
          []
        )
      end
      tags 'Rooms'
      produces 'application/json'
      response '200', 'room list' do
        schema type: :object,
               properties: {
                 list: { type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: { type: :number },
                             name: { type: :string }
                           },
                           required: %i[id name]
                         } }
               },
               required: %i[list]
        run_test!
      end
    end

    post 'Create Room' do
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
        properties: {
          user_id: { type: :number }
        },
        required: %i[user_id]
      }
      response '200', 'room created' do
        let(:user_id) { { user_id: 1 } }
        schema type: :object,
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
               properties: {
                 id: { type: :number },
                 name: { type: :string, nullable: true },
                 store1: {
                   type: :object,
                   properties: { id: { type: :number }, name: { type: :string } },
                   required: %w[id name]
                 },
                 store2: {
                   type: :object,
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
        properties: {
          store1_id: { type: :number, nullable: true },
          store2_id: { type: :number, nullable: true }
        },
        required: %w[store1_id store2_id]
      }
      response '200', 'room updated' do
        let(:room_id) { create(:room).id }
        run_test!
      end
    end
  end
end
