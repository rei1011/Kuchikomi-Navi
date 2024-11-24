# frozen_string_literal: true

require 'json'

# 店舗間の比較レポートを取得する
class MessagesController < ApplicationController
  def index
    messages = MessageService.find(params['room_id'])
    render json: ReportSerializer.render(messages)
  end

  def create
    MessageService.create(params['room_id'], params['message'])
    render json: {}
  end
end
