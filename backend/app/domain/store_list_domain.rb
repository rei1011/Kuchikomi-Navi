# frozen_string_literal: true

# 店舗の一覧を保持するクラス
class StoreListDomain
  attr_reader :list

  def initialize(stores)
    @list = stores
  end

  def find_by_prefecture(prefecture)
    stores = @list.select do |store|
      prefecture.include?(store.address.prefecture)
    end
    StoreListDomain.new(stores)
  end
end
