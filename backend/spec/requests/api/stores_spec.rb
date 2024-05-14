# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/stores', type: :request do
  path '/stores' do
    get 'Get Stores' do
      tags 'Stores'
      produces 'application/json'
      response '200', 'store found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   store_name: { type: :string },
                   address: {
                     type: :object,
                     properties: {
                       prefecture: { type: :string },
                       municipality: { type: :string }
                     },
                     required: %i[prefecture municipality]
                   },
                   home_page: { type: :string },
                   store_image: { type: :string }
                 },
                 required: %i[id store_name address home_page store_image]
               }
        run_test!
      end
    end
  end
end
