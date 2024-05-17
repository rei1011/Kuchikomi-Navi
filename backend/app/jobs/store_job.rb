# frozen_string_literal: true

# 複数サイトから収集した店舗情報を保存
class StoreJob
  def self.perform
    store = Store.new(store_name: 'sample store 1',
                      prefecture: 'sample prefecture',
                      municipality: 'sample municipality',
                      home_page: 'https://sample.co.jp',
                      store_image: 'https://sample.co.jp/sample.jpg')
    store.save
  end
end
