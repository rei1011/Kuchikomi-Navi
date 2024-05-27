# frozen_string_literal: true

# 営業時刻
class OpenHours
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
  end

  class << self
    # 「10:00～4:00 （最終受付 4:00）」のような形式の文字列からfromとtoを抽出する
    def from_time_str(time_str)
      if ['24時間', '24時間(受付)'].include?(time_str)
        OpenHours.new(from: '00:00', to: '00:00')
      else
        open = time_str.gsub(' ', '').split(/[～〜]/)[0, 2]
        formatted_time = open.map do |time|
          next nil unless time =~ /(?:翌|AM)?(\d{1,2}):(\d{2})/

          hour = ::Regexp.last_match(1).to_i
          minute = ::Regexp.last_match(2).to_i
          # 時と分をゼロパディングして結合
          format('%<hour>02d:%<minute>02d', hour:, minute:)
        end
        OpenHours.new(from: formatted_time[0], to: formatted_time[1])
      end
    end
  end
end
