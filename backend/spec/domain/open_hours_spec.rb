# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OpenHours' do
  it '営業時間の文字列から開店時刻と閉店時刻を取得する' do
    list = [
      { input: '10:00～4:00 ', expected: { from: '10:00', to: '04:00' } },
      { input: '10:00～4:00 （最終受付 4:00）', expected: { from: '10:00', to: '04:00' } },
      { input: '11:00～24:00(最終受付22:00)', expected: { from: '11:00', to: '24:00' } },
      { input: '10:00～24:00(受付9:30～)', expected: { from: '10:00', to: '24:00' } },
      { input: '24時間', expected: { from: '00:00', to: '00:00' } },
      { input: '10:00～LAST', expected: { from: '10:00', to: nil } },
      { input: 'AM10:00〜翌5:00', expected: { from: '10:00', to: '05:00' } },
      { input: '11:00〜23:00(受付 10:00～22:00)', expected: { from: '11:00', to: '23:00' } },
      {
        input: "\n                                                9:00～24:00\n                                            ", expected: {
          from: '09:00', to: '24:00'
        }
      }
    ]

    list.each do |data|
      result = OpenHours.from_time_str(data[:input])
      expect(result.from).to eq data[:expected][:from]

      expect(result.to).to eq data[:expected][:to]
    end
  end
end
