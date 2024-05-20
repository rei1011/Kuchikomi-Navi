# frozen_string_literal: true

require_relative './res/stores_res'

class StoresController < ApplicationController # rubocop:disable Style/Documentation
  def index
    stores = Store.all
    new_variable = StoresRes.new(stores)
    render(json: new_variable)
  end
end
