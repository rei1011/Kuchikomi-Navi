# frozen_string_literal: true

require 'faraday'

# 店舗間の比較レポートを出力するサービス
class MessageService
  def self.find(room_id)
    MessageRepository.find_by_room_id(room_id)
  end

  def self.create(room_id, new_message)
    MessageRepository.create(room_id, new_message, true)
  end
end
