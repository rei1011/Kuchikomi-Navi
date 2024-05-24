# frozen_string_literal: true

# 店舗に関する情報を取得するためのAPI
class StoresController < ApplicationController
  def index
    stores = StoreService.find(SearchWord.new(params[:keyword]))
    render(json: StoresRes.new(stores))
  end

  def error_test
    stores = StoreService.find(SearchWord.new(params[:keyword]))
    TestService.test
    render(json: StoresRes.new(stores))
  rescue StandardError => e
    Rails.logger.error "#{e.class}: #{e}"
    Rails.logger.error e.backtrace
  end
end
