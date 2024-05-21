# frozen_string_literal: true

# 店舗に関する情報を取得するためのAPI
class StoresController < ApplicationController
  def index
    stores = Store.all
    render(json: StoresRes.new(stores))
  end
end
