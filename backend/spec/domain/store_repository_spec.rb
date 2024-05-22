# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreRepository do
  it 'find by prefecture name' do
    Store.create(store_name: '東京店',
                 prefecture: '東京',
                 municipality: '池袋',
                 store_image: 'https://sample.co.jp',
                 "home_page": 'https://sample.co.jp/photo.jpg')
    Store.create(store_name: '東京店',
                 prefecture: '東京',
                 municipality: '五反田',
                 store_image: 'https://sample.co.jp',
                 "home_page": 'https://sample.co.jp/photo.jpg')
    Store.create(store_name: '埼玉店',
                 prefecture: '埼玉',
                 municipality: '秩父',
                 store_image: 'https://sample.co.jp',
                 "home_page": 'https://sample.co.jp/photo.jpg')
    stores = StoreRepository.find_by_prefecture('東京')
    expect(stores.size).to eq 2
    expect(stores[0].address.municipality).to eq '池袋'
    expect(stores[1].address.municipality).to eq '五反田'
  end

  it 'Returns an empty array when there is no store information' do
    stores = StoreRepository.find_by_prefecture('東京')
    expect(stores.size).to eq 0
  end
end
