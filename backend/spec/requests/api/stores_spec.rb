# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/stores', type: :request do # rubocop:disable Metrics/BlockLength
  before do
    allow(StoreService).to receive(:find).and_return(
      [
        StoreDomain.new(
          store_name: 'sample store',
          store_image: 'https://sample.co.jp/sample.jpg',
          home_page: 'https://sample.co.jp',
          prefecture: 'smaple',
          municipality: 'sample',
          open_hours: OpenHours.new(from: '10:00', to: '19:00'),
          data_source: DataSource.new(DataSource::UNKNOWN)
        )
      ]
    )
  end

  path '/stores' do # rubocop:disable Metrics/BlockLength
    get 'Get Stores' do # rubocop:disable Metrics/BlockLength
      tags 'Stores'
      parameter name: :keyword,
                in: :query,
                type: :string
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true, description: 'Authorization token'
      response '200', 'store found' do
        let(:keyword) { 'keyword' }
        schema type: :object,
               properties: {
                 list: { type: :array,
                         items: {
                           type: :object,
                           properties: {
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
                             store_image: { type: :string },
                             open: {
                               type: :object,
                               properties: {
                                 # 営業時間はHH:MMの形式で表現する
                                 from: { type: :string, pattern: /^(?:[01]\d|2[0-3]):[0-5]\d$/ },
                                 to: { type: :string, pattern: /^(?:[01]\d|2[0-3]):[0-5]\d$/ }
                               }
                             }
                           },
                           required: %i[store_name address home_page open]
                         } }
               },
               required: %i[list]
        let(:Authorization) do
          "Basic #{Base64.encode64("#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}")}"
        end
        run_test!
      end
    end
  end
end
