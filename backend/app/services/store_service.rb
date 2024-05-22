# frozen_string_literal: true

# 店舗情報を取得するためもサービス
class StoreService
  def self.find(search_word)
    return StoreRepository.find_all if search_word.empty

    StoreRepository.find_by_prefecture(search_word.value)
  end
end
