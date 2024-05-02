# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/comments', type: :request do
  path '/comments' do
    get 'Get Comments' do
      tags 'Comments'
      consumes 'application/json'

      response '200', 'get comments' do
        run_test!
      end
    end
  end
end
