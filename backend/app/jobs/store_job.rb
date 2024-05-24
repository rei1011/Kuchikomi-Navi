# frozen_string_literal: true

# 複数サイトから収集した店舗情報を保存
class StoreJob
  def self.perform # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    Store.transaction do
      # MySQLではtruncateした場合rollbackができないので、deleteでデータを削除している
      Store.delete_all
      stores = []
      store_list_from_fujoho = FujohoService.find
      store_list_from_fuzoku = FuzokuService.find
      store_list = store_list_from_fujoho.add_stores(store_list_from_fuzoku).uniq
      store_list.list.each do |store|
        stores.push({
                      store_name: store.store_name,
                      prefecture: store.address.prefecture,
                      municipality: store.address.municipality,
                      home_page: store.home_page,
                      store_image: store.store_image
                    })
      end
      Store.insert_all(stores)
    end
  rescue StandardError => e
    KuchikomiLogger.error e
  end
end
