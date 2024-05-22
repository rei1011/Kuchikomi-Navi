# frozen_string_literal: true

# 店舗の一覧を返却するための型
class StoresRes
  def initialize(stores)
    @list = []
    stores.each_with_index do |store, index|
      # TODO: idをStoreDomainから取得する
      @list.push({ id: index,
                   store_name: store.store_name,
                   address: store.address,
                   home_page: store.home_page,
                   store_image: store.store_image })
    end
  end
end
