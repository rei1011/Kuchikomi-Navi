# frozen_string_literal: true

# チャットルームのの一覧を取得するためのAPI
class RoomsController < ApplicationController
  def index
    # TODO: user_idをheaderから取得できるようにする
    user_id = '1'
    rooms = RoomService.find(user_id)
    render json: { list: rooms }
  end
end
