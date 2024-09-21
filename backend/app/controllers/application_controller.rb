# frozen_string_literal: true

# ApplicationControllerの基底クラス
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      puts 'authentication user'
      puts ENV['BASIC_AUTH_USER']
      puts 'authentication password'
      puts ENV['BASIC_AUTH_PASSWORD']
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
