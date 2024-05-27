# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'get store from fujoho page' do
  it do
    # 店舗一覧のmock
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/fujoho/shop_list_response.txt')
    stub_request(:get, %r{https://fujoho\.jp/index\.php\?(.*&)?p=shop_list(&.*)?$})
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })

    # 店舗一覧のmock（3ページ目に表示される店舗数が0件と仮定）
    raw_empty_shop_list_file = File.new('/usr/src/app/backend/spec/services/fujoho/empty_shop_list_response copy.txt')
    stub_request(:get, 'https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F&b=2')
      .to_return(status: 200,
                 body: raw_empty_shop_list_file,
                 headers: { content_type: 'text/html' })

    # 店舗詳細のmock
    raw_shop_detail_file = File.new('/usr/src/app/backend/spec/services/fujoho/shop_detail_response.txt')
    stub_request(:get, %r{https://fujoho\.jp/index\.php\?id=\d+&p=shop})
      .to_return(status: 200, body: raw_shop_detail_file, headers: { content_type: 'text/html' })

    store_list = FujohoService.find
    expect(store_list.list.size).to eq 200
    store_list.list.each do |store|
      expect(store.store_name).not_to eq nil
      expect(store.address.prefecture).not_to eq nil
      expect(store.address.municipality).not_to eq nil
      expect(store.home_page).not_to eq nil
    end
  end
end
