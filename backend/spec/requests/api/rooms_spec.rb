# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/rooms', type: :request do
  path '/rooms' do
    get 'Get Rooms' do
      tags 'Rooms'
      produces 'application/json'
      response '200', 'room list' do
        schema type: :object,
               properties: {
                 list: { type: :array,
                         items: {
                           type: :object,
                           properties: {
                             id: { type: :string },
                             name: { type: :string }
                           },
                           required: %i[id name]
                         } }
               },
               required: %i[list]
        run_test!
      end
    end
  end
end
