# frozen_string_literal: true

# 店舗情報を保持する
class StoreDomain
  attr_reader :id, :store_name, :address, :store_image, :home_page, :open_hours, :data_source

  def initialize(id:, store_name:, prefecture:, municipality:, home_page:, store_image:, open_hours:, data_source:) # rubocop:disable Metrics/ParameterLists
    @id = id # idはnilの場合がある
    @store_name = store_name
    @address = Address.new(prefecture:, municipality:)
    @store_image = store_image
    @home_page = home_page
    @open_hours = open_hours
    @data_source = data_source
  end
end
