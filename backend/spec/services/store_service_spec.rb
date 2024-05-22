# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StoreService' do
  def create_store(prefecture)
    Store.create(
      store_name: 'sample',
      store_image: 'https://sample.co.jp/sample.jpg',
      home_page: 'https://sample.co.jp',
      municipality: 'sample',
      prefecture:
    )
  end

  it 'keywordが指定された場合は、該当する店舗を取得' do
    create_store('東京')
    create_store('埼玉')
    stores = StoreService.find(SearchWord.new('東京'))
    expect(stores.size).to eq 1
    expect(stores[0].address.prefecture).to eq '東京'
  end

  it 'keywordが指定されていない場合は、全店舗を取得' do
    create_store('東京')
    create_store('埼玉')
    stores = StoreService.find(SearchWord.new(nil))
    expect(stores.size).to eq 2
  end
end
