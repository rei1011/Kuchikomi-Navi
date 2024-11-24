# frozen_string_literal: true

require 'json'

# 店舗間の比較レポートを取得する
class MessagesController < ApplicationController
  def index
    query_params = Rack::Utils.parse_query(request.query_string)
    message = MessageService.find(query_params['stores'], query_params['message'], params['room_id'])
    render json: ReportSerializer.render(message)
  end
end
