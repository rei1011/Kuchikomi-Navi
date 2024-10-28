# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/comparison_report', type: :request do
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
          'X-Api-Key' => 'hogehoge'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end

  path '/comparison_report' do
    get 'Get Comparison Report' do
      tags 'Comparison Report'
      consumes 'application/json'
      parameter name: :request_body, in: :body, schema: {
        type: :object,
        properties: {
          stores: {
            type: :array,
            items: { type: :string },
            example: %w[uuid1 uuid2]
          },
          compare_method: {
            type: :string,
            example: 'おすすめのお店を教えて'
          }
        },
        required: %w[stores compare_method]
      }
      parameter name: 'Authorization', in: :header, type: :string, required: true,
                description: 'Authorization token'
      produces 'application/json'
      response '200', 'Comparison Report found' do
        schema type: :object,
               properties: {
                 report: { type: :string }
               },
               required: %i[report]
        let(:Authorization) do
          "Basic #{Base64.encode64("#{ENV['BASIC_AUTH_USER']}:#{ENV['BASIC_AUTH_PASSWORD']}")}"
        end
        run_test!
      end
    end
  end
end
