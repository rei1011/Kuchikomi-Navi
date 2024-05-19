# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'get store from fujoho page' do
  it do
    # 店舗一覧のmock
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/shop_list_response.txt')
    stub_request(:get, %r{https://fujoho\.jp/index\.php\?(.*&)?p=shop_list(&.*)?$})
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })

    # 店舗詳細のmock
    raw_shop_detail_file = File.new('/usr/src/app/backend/spec/services/shop_detail_response.txt')
    stub_request(:get, %r{https://fujoho\.jp/index\.php\?id=\d+&p=shop})
      .to_return(status: 200, body: raw_shop_detail_file, headers: { content_type: 'text/html' })

    store = FujohoService.get
    expect(store.size).to eq 100
  end
end
