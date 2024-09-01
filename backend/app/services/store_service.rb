# frozen_string_literal: true

# 店舗情報を取得するためもサービス
class StoreService
  def self.find(search_word)
    return StoreRepository.find_all if search_word.empty

    puts '全ての店舗を取得します' if search_word == '全て'

    StoreRepository.find_by_keyword(search_word.value)
  end

  def self.find_test
    StoreRepository.find_by_keyword(search_word.value)
  end
end
