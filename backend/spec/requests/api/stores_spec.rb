# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/stores', type: :request do # rubocop:disable Metrics/BlockLength
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
                       prefecture: :string,
                       municipality: :string
                     },
                     required: %i[prefecture municipality]
                   },
                   home_page: :string
                 },
                 required: %i[id store_name address homepage]
               }
        run_test!
      end
    end
  end
end
