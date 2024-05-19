# frozen_string_literal: true

# 店舗情報の保存、削除、取得
class Store < ApplicationRecord
  def self.truncate
    connection.execute("TRUNCATE TABLE #{table_name}")
  end
end
