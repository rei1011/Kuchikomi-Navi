# frozen_string_literal: true

# チャットルームを取得するためのリポジトリ
class RoomRepository
  def self.find_by_id(room_id)
    Room.find(room_id)
  end

  def self.find_by_user_id(user_id)
    Room.where(user_id:)
  end

  def self.create(user_id)
    Room.create!(user_id:, name: '')
  end

  def self.update(room)
    Room.find(room.id).update!(store1_id: room.store1_id, store2_id: room.store2_id)
  end

  def self.delete(room_id)
    Room.destroy(room_id)
  end
end
