# frozen_string_literal: true

require 'date'

# 店舗の一覧を返却するための型
class StoresRes
  def initialize(stores)
    @list = []
    stores.each do |store|
      new_variable = {
        store_name: store.store_name,
        address: store.address,
        home_page: store.home_page,
        store_image: store.store_image,
        open: {
          from: '10:00',
          to: '19:00'
        }
      }
      @list.push(
        new_variable
      )
    end
  end
end
