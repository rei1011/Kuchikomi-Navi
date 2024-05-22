# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchWord do
  tests = [
    { input: nil, expected: true },
    { input: '', expected: true }
  ]

  tests.each do |t|
    describe "Given input #{t[:input]}" do
      it "returns #{t[:expected]}" do
        expect(SearchWord.new(t[:input]).empty).to eq true
      end
    end
  end
end
