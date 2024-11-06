# frozen_string_literal: true

# == Schema Information
#
# Table name: stores
#
#  id           :bigint           not null, primary key
#  store_name   :string(255)      not null
#  prefecture   :string(255)      not null
#  municipality :string(255)      not null
#  home_page    :text(65535)      not null
#  store_image  :text(65535)
#  open_from    :string(255)
#  open_to      :string(255)
#  data_source  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
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
