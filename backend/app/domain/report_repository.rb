# frozen_string_literal: true

require 'faraday'

# 店舗間の比較レポートを取得する
class ReportRepository
  def self.find(stores, compare_method) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    conn = Faraday.new(url: 'https://api.anthropic.com') do |f|
      f.adapter Faraday.default_adapter
    end

    content = compare_method + stores.to_s
    response = conn.post('/v1/messages') do |req|
      req.headers['x-api-key'] = Rails.application.credentials.claude[:api_key]
      req.headers['anthropic-version'] = '2023-06-01'
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        model: 'claude-3-haiku-20240307',
        max_tokens: 1024,
        messages: [
          { role: 'user', content: }
        ]
      }.to_json
    end

    JSON.parse(response.body)['content'][0]['text']
  end
end
