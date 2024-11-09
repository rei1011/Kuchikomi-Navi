# frozen_string_literal: true

require 'faraday'

# 店舗間の比較レポートを出力するサービス
class ReportService
  def self.find(store_ids, compare_method)
    stores = StoreRepository.find_by_ids(store_ids)
    ReportRepository.find(stores, compare_method)
  end
end
