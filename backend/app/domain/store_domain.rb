# frozen_string_literal: true

# 店舗情報を保持する
class StoreDomain
  def initialize(store_name:, prefecture:, municipality:, home_page:, store_image:)
    @store_name = store_name
    @address = {
      prefecture:,
      municipality:
    }
    @store_image = store_image
    @home_page = home_page
  end

  attr_reader :store_name, :address, :store_image, :home_page
end
