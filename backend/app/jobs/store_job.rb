# frozen_string_literal: true

# 複数サイトから収集した店舗情報を保存
class StoreJob
  def self.perform # rubocop:disable Metrics/MethodLength
    Store.transaction do
      # MySQLではtruncateした場合rollbackができないので、deleteでデータを削除している
      Store.delete_all
      stores = []
      FujohoService.get.each do |store|
        stores.push({
                      store_name: store[:store_name],
                      prefecture: store[:prefecture],
                      municipality: store[:municipality],
                      home_page: store[:home_page],
                      store_image: store[:store_image]
                    })
      end
      Store.insert_all(stores)
    end
  rescue StandardError => e
    Rails.logger.error e
  end
end
