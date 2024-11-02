# frozen_string_literal: true

require 'swagger_helper'
require 'rails_helper'
require 'base64'

RSpec.describe 'api/comparison_report', type: :request do
  before do
    allow(ReportService).to receive(:find).and_return('report')
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
