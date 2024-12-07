# frozen_string_literal: true

require 'json'

# 店舗間の比較レポートを取得する
class MessagesController < ApplicationController
  include ActionController::Live

  def index
    messages = MessageService.find(params['room_id'])
    render json: MessageSerializer.render(messages)
  end

  def create
    MessageService.create(params['room_id'], params['message'])
    render json: {}
  end

  def sse # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength
    room_id = params['room_id']
    is_show = true
    messages = MessageRepository.find_all_by_room_id(room_id)
    conn = connection
    streamd = ''
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate
    sse = SSE.new(response.stream, event: 'message')

    conn.post('/v1/messages') do |req|
      req.headers['x-api-key'] = Rails.application.credentials.claude[:api_key]
      req.headers['anthropic-version'] = '2023-06-01'
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        model: 'claude-3-haiku-20240307',
        max_tokens: 1024,
        messages: messages.map { |m| { "role": m.role, "content": m.value } },
        stream: true
      }.to_json

      req.options.on_data = proc do |chunk|
        chunk.split("\n\n")
             .map { |block| block.match(/data: (\{.*\})/)&.captures&.first }
             .compact
             .map { |json_str| JSON.parse(json_str).dig('delta', 'text') }
             .compact
             .each do |text|
          next if text.empty?

          streamd += text
          sse.write({ message: text })
        end
      end
    end

    Message.create!(room_id:, role: 'assistant', value: streamd, is_show:)
  ensure
    sse.close
  end

  private

  def connection
    Faraday.new(url: 'https://api.anthropic.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
