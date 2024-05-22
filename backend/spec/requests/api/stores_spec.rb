# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'api/stores', type: :request do # rubocop:disable Metrics/BlockLength
  before do
    allow(StoreRepository).to receive(:find_all).and_return(
      [
        StoreDomain.new(
          store_name: 'sample store',
          store_image: 'https://sample.co.jp/sample.jpg',
          home_page: 'https://sample.co.jp',
          prefecture: 'smaple',
          municipality: 'sample'
        )
      ]
    )
  end

  path '/stores' do # rubocop:disable Metrics/BlockLength
    get 'Get Stores' do # rubocop:disable Metrics/BlockLength
      tags 'Stores'
      produces 'application/json'
      response '200', 'store found' do
        schema type: :object,
               properties: {
                 list: { type: :array,
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
                           required: %i[id store_name address home_page]
                         } }
               },
               required: %i[list]
        run_test!
      end
    end
  end
end
