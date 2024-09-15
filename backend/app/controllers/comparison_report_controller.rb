# frozen_string_literal: true

require 'faraday'
require 'json'

# 店舗間の比較レポートを取得する
class ComparisonReportController < ApplicationController
  def show
    # Faradayクライアントの作成
    conn = Faraday.new(url: 'https://api.anthropic.com') do |f|
      f.adapter Faraday.default_adapter # デフォルトのアダプターを使用
    end

    # POSTリクエストを実行
    response = conn.post('/v1/messages') do |req|
      # ヘッダーを設定
      req.headers['x-api-key'] = Rails.application.credentials.claude[:api_key]
      req.headers['anthropic-version'] = '2023-06-01'
      req.headers['Content-Type'] = 'application/json'

      # ボディを設定
      req.body = {
        model: 'claude-3-haiku-20240307',
        max_tokens: 1024,
        messages: [
          { role: 'user', content: 'Hello, world' }
        ]
      }.to_json
    end

    puts response.body
  end
end
