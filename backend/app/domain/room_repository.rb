# frozen_string_literal: true

# チャットルームを取得するためのリポジトリ
class RoomRepository
  def self.find_by_user_id(user_id)
    Room.where(user_id:)
  end

  def self.create(user_id)
    Room.create(user_id:)
  end
end
