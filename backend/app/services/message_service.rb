# frozen_string_literal: true

require 'faraday'

# 店舗間の比較レポートを出力するサービス
class MessageService
  def self.find(store_ids, new_message, room_id)
    stores = StoreRepository.find_by_ids(store_ids)
    messages = MessageRepository.find_by_room_id(room_id)
    MessageRepository.create(stores, room_id, new_message, messages)
    MessageRepository.find_by_room_id(room_id)
  end
end
