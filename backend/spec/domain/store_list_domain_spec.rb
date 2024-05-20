# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreListDomain do
  it 'find by prefecture name' do
    store1 = StoreDomain.new(store_name: '東京店',
                             prefecture: '東京',
                             municipality: '池袋',
                             store_image: 'https://sample.co.jp',
                             "home_page": 'https://sample.co.jp/photo.jpg')
    store2 = StoreDomain.new(store_name: '埼玉店',
                             prefecture: '埼玉',
                             municipality: '秩父',
                             store_image: 'https://sample.co.jp',
                             "home_page": 'https://sample.co.jp/photo.jpg')
    store_list = StoreListDomain.new([store1, store2])
    selected_store_list = store_list.find_by_prefecture(%w[東京 千葉])
    expect(selected_store_list.list.size).to eq 1
    expect(selected_store_list.list[0].address.prefecture).to eq '東京'
  end

  it 'If there is no corresponding store' do
    store1 = StoreDomain.new(store_name: '東京店',
                             prefecture: '東京',
                             municipality: '池袋',
                             store_image: 'https://sample.co.jp',
                             "home_page": 'https://sample.co.jp/photo.jpg')
    store2 = StoreDomain.new(store_name: '埼玉店',
                             prefecture: '埼玉',
                             municipality: '秩父',
                             store_image: 'https://sample.co.jp',
                             "home_page": 'https://sample.co.jp/photo.jpg')
    store_list = StoreListDomain.new([store1, store2])
    selected_store_list = store_list.find_by_prefecture(['千葉'])
    expect(selected_store_list.list.size).to eq 0
  end
end
