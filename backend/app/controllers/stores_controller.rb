# frozen_string_literal: true

require_relative './res/stores_res'

# 店舗に関する情報を取得するためのAPI
class StoresController < ApplicationController
  def index
    stores = Store.all
    new_variable = Res::StoresRes.new(stores)
    render(json: new_variable)
  end
end
