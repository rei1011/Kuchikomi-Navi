# frozen_string_literal: true

# チャットルームの一覧を取得する
class RoomService
  def self.find(user_id)
    RoomRepository.find_by_user_id(user_id)
  end

  def self.find_by_id(room_id)
    RoomRepository.find_by_id(room_id)
  end

  def self.create(user_id)
    RoomRepository.create(user_id)
  end

  def self.update(room)
    RoomRepository.update(room)
    stores = StoreRepository.find_by_room_id(room.id)
    return unless stores.length == 2

    new_message = "これ以降は以下2店舗の情報を利用し回答するようにして欲しいです。\n#{stores}\n理解できましたか？"
    MessageRepository.create(room.id, new_message, false)
  end

  def self.delete(room_id)
    RoomRepository.delete(room_id)
  end
end
