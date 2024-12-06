# frozen_string_literal: true

require 'faraday'

class MessageRepository # rubocop:disable Style/Documentation
  def self.find_by_room_id(room_id)
    Message.where(room_id:).and(Message.where(is_show: true)).order(created_at: :asc, id: :asc)
  end

  def self.find_all_by_room_id(room_id)
    Message.where(room_id:).order(created_at: :asc, id: :asc)
  end

  def self.create(room_id, new_message, old_messages, is_show) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    conn = connection

    all_messages = old_messages.map do |m|
      { "role": m.role, "content": m.value }
    end.push({ "role": 'user', "content": new_message })

    streamd = ''

    begin
      conn.post('/v1/messages') do |req|
        req.headers['x-api-key'] = Rails.application.credentials.claude[:api_key]
        req.headers['anthropic-version'] = '2023-06-01'
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          model: 'claude-3-haiku-20240307',
          max_tokens: 1024,
          messages: all_messages,
          stream: true
        }.to_json

        req.options.on_data = proc do |chunk|
          json_match = chunk.match(/data: (\{.*\})/)
          next unless json_match

          begin
            parsed_data = JSON.parse(json_match[1])
            m = parsed_data.dig('delta', 'text')
            streamd += m if m
          rescue JSON::ParserError
            nil
          end
        end
      end

      Message.create!(room_id:, role: 'user', value: new_message, is_show:)
      Message.create!(room_id:, role: 'assistant', value: streamd, is_show:)
    rescue StandardError => e
      KuchikomiLogger.error e
      Message.create!(room_id:, role: 'user', value: new_message, is_show:)
    end
  end

  def self.connection
    Faraday.new(url: 'https://api.anthropic.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private_class_method :connection
end
