# frozen_string_literal: true

# 店舗情報の保存、削除、取得
class Store < ApplicationRecord
  def to_domain
    StoreDomain.new(
      store_name:,
      store_image:,
      home_page:,
      prefecture:,
      municipality:
    )
  end
end
