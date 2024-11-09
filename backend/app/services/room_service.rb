# frozen_string_literal: true

# チャットルームの一覧を取得する
class RoomService
  def self.find(user_id)
    RoomRepository.find_by_user_id(user_id)
  end

  def self.create(user_id)
    RoomRepository.create(user_id)
  end

  def self.update(room)
    RoomRepository.update(room)
  end
end
