# frozen_string_literal: true

# 店舗の一覧を返却するための型
class StoresRes
  def initialize(stores)
    @list = []
    stores.each do |store|
      @list.push(
        {
          store_name: store.store_name,
          address: store.address,
          home_page: store.home_page,
          store_image: store.store_image
        }
      )
    end
  end
end
