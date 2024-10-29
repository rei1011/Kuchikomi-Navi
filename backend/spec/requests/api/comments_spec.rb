# frozen_string_literal: true

require 'swagger_helper'
require 'base64'

RSpec.describe 'api/comments', type: :request do
  path '/comments' do
    get 'Get Comments' do
      tags 'Comments'
      produces 'application/json'
      response '200', 'comment found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   store_name: { type: :string },
                   prostutite_name: { type: :string },
                   comment: { type: :string },
                   publication_date: { type: :date }
                 },
                 required: %i[id store_name prostutite_name comment publication_date]
               }
        run_test!
      end
    end
  end
end
