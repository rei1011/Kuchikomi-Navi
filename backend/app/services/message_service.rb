# frozen_string_literal: true

require 'faraday'

# 店舗間の比較レポートを出力するサービス
class MessageService
  def self.find(room_id)
    MessageRepository.find_by_room_id(room_id)
  end

  def self.create(room_id, new_message)
    messages = MessageRepository.find_all_by_room_id(room_id)
    MessageRepository.create(room_id, new_message, messages, true)
  end
end
