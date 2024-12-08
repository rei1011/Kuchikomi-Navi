# frozen_string_literal: true

# ApplicationControllerの基底クラス
class ApplicationController < ActionController::API
  @@current_user_id = 2

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :basic_auth

  private

  def basic_auth
    # テスト環境の場合はBasic認証をスキップ
    return true if ENV['RAILS_ENV'] == 'test'

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
