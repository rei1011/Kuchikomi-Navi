# frozen_string_literal: true

# 店舗情報の保存、取得を行う
class StoreRepository
  def self.find_all
    Store.all.map(&:to_domain)
  end

  def self.find_by_prefecture(prefecture)
    Store.where('prefecture LIKE ?', "%#{prefecture}%").map(&:to_domain)
  end

  def self.find_by_municipality(municipality)
    Store.where(municipality:).map(&:to_domain)
    Store.where('municipality LIKE ?', "%#{municipality}%").map(&:to_domain)
  end

  def self.find_by_store_name(store_name)
    Store.where('store_name LIKE ?', "%#{store_name}%").map(&:to_domain)
  end

  def self.find_by_keyword(keyword)
    Store.where('prefecture LIKE ? OR municipality LIKE ? OR store_name LIKE ?', "%#{keyword}%", "%#{keyword}%",
                "%#{keyword}%").map(&:to_domain)
  end
end
