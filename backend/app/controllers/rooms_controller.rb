# frozen_string_literal: true

# チャットルームのの一覧を取得するためのAPI
class RoomsController < ApplicationController
  def index
    # TODO: user_idをheaderから取得できるようにする
    user_id = '2'
    rooms = RoomService.find(user_id)
    render json: { list: rooms }
  end

  def create
    room = RoomService.create(params[:user_id])
    render json: { id: room.id }
  end
end
