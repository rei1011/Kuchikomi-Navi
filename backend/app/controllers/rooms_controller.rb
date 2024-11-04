# frozen_string_literal: true

# チャットルームのの一覧を取得するためのAPI
class RoomsController < ApplicationController
  def index
    render json: { list: [] }
  end
end
