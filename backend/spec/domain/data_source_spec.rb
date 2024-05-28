# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DataSource' do
  it 'データソースを取得できる' do
    result = DataSource.new(DataSource::FUJOHO)
    expect(result.value).to eq 0

    result2 = DataSource.new(0)
    expect(result2.value).to eq 0
  end

  it 'データソースが不明の場合はnilを返却する' do
    result = DataSource.new(DataSource::UNKNOWN)
    expect(result.value).to eq nil
  end
end
