# frozen_string_literal: true

# 店舗情報を取得するためもサービス
class StoreService
  def self.find(search_word)
    return StoreRepository.find_all if search_word.empty

    stores = StoreRepository.find_by_prefecture(search_word.value)
    stores.concat(StoreRepository.find_by_municipality(search_word.value))
    stores.concat(StoreRepository.find_by_store_name(search_word.value))
    StoreListDomain.new(stores).uniq.list
  end
end
