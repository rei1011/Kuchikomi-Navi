# frozen_string_literal: true

require 'faraday'

class MessageRepository # rubocop:disable Style/Documentation
  def self.find_by_room_id(room_id)
    Message.where(room_id:).order(created_at: :asc, id: :asc)
  end

  def self.create(stores, room_id, new_message, old_messages) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    conn = connection

    message = old_messages.empty? ? new_message + stores.to_s : new_message
    all_messages = old_messages.map do |m|
      { "role": m.role, "content": m.value }
    end.push({ "role": 'user', "content": message })

    begin
      response = conn.post('/v1/messages') do |req|
        req.headers['x-api-key'] = Rails.application.credentials.claude[:api_key]
        req.headers['anthropic-version'] = '2023-06-01'
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          model: 'claude-3-haiku-20240307',
          max_tokens: 1024,
          messages: all_messages

        }.to_json
      end
      Message.create!(room_id:, role: 'user', value: message)
      Message.create!(room_id:, role: 'assistant', value: JSON.parse(response.body)['content'][0]['text'])
    rescue StandardError => e
      KuchikomiLogger.error e
      Message.create!(room_id:, role: 'user', value: message)
    end
  end

  def self.connection
    Faraday.new(url: 'https://api.anthropic.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private_class_method :connection
end
