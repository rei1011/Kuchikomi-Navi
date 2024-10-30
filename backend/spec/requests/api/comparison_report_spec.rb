# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/comparison_report', type: :request do # rubocop:disable Metrics/BlockLength
  before do
    stub_request(:post, 'https://api.anthropic.com/v1/messages')
      .with(
        body: '{"model":"claude-3-haiku-20240307","max_tokens":1024,"messages":[{"role":"user","content":"Hello, world"}]}',
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Anthropic-Version' => '2023-06-01',
          'Content-Type' => 'application/json',
          'User-Agent' => 'Faraday v2.9.0',
          'X-Api-Key' => Rails.application.credentials.claude[:api_key]
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end

  path '/comparison_report' do
    get 'Get Comparison Report' do
      tags 'Comparison Report'
      consumes 'application/json'
      parameter name: :stores, in: :query, type: :array, items: { type: :string }, required: true
      parameter name: :compare_method, in: :query, type: :string, required: true
      produces 'application/json'
      response '200', 'Comparison Report found' do
        schema type: :object,
               properties: {
                 report: { type: :string }
               },
               required: %i[report]
        let(:stores) { %w[uuid1 uuid2] }
        let(:compare_method) { 'おすすめのお店を教えて' }

        run_test!
      end
    end
  end
end
