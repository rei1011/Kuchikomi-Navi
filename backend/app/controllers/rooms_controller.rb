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

  def update
    RoomService.update(Room.new do |r|
      r.id = params[:room_id]
      r.user_id = '2'
      r.store1_id = params[:store1_id]
      r.store2_id = params[:store2_id]
    end)
    render status: 200
  end
end
