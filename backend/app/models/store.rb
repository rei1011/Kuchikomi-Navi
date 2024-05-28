# frozen_string_literal: true

# 店舗情報の保存、削除、取得
class Store < ApplicationRecord
  def to_domain
    StoreDomain.new(
      store_name:,
      store_image:,
      home_page:,
      prefecture:,
      municipality:,
      open_hours: OpenHours.new(from: open_from, to: open_to),
      data_source: DataSource.new(data_source)
    )
  end
end
