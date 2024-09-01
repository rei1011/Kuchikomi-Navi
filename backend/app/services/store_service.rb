# frozen_string_literal: true

# 店舗情報を取得するためもサービス
class StoreService
  def self.find(search_word)
    return StoreRepository.find_all if search_word.empty

    if(search_word == "全て") do
      puts "全ての店舗を取得します"
    end

    StoreRepository.find_by_keyword(search_word.value)
  end
end
