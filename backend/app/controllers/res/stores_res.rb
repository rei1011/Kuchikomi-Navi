# frozen_string_literal: true

# 店舗の一覧を返却するための型
class StoresRes
  def initialize(stores)
    @list = []
    stores.all.each do |store|
      @list.push({ id: store[:id],
                   store_name: store[:store_name],
                   address: {
                     prefecture: store[:prefecture],
                     municipality: store[:municipality]
                   },
                   home_page: store[:home_page],
                   store_image: store[:store_image] })
    end
  end
end
