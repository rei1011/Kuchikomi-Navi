# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StoreService' do
  def create_store(
    store_name,
    prefecture,
    municipality,
    home_page = 'https://sample.co.jp'
  )
    Store.create(
      store_name:,
      store_image: 'https://sample.co.jp/sample.jpg',
      home_page:,
      municipality:,
      prefecture:
    )
  end

  it '県名で検索できる' do
    create_store('sample', '東京', '池袋')
    create_store('sample', '埼玉', '秩父')
    stores = StoreService.find(SearchWord.new('東京'))
    expect(stores.size).to eq 1
    expect(stores[0].address.prefecture).to eq '東京'
  end

  it '市区町村で検索できる' do
    create_store('sample', '東京', '池袋')
    create_store('sample', '埼玉', '秩父')
    stores = StoreService.find(SearchWord.new('池袋'))
    expect(stores.size).to eq 1
    expect(stores[0].address.prefecture).to eq '東京'
  end

  it '店名で検索できる' do
    create_store('痴漢', '東京', '池袋')
    create_store('M性感', '埼玉', '秩父')
    stores = StoreService.find(SearchWord.new('痴漢'))
    expect(stores.size).to eq 1
    expect(stores[0].address.prefecture).to eq '東京'
  end

  it '重複は除外されている' do
    create_store('痴漢', '東京', '池袋')
    create_store('東京', '埼玉', '秩父', "'https://sample.ne.jp'")
    stores = StoreService.find(SearchWord.new('東京'))
    expect(stores.size).to eq 2
  end

  it 'keywordが指定されていない場合は、全店舗を取得' do
    create_store('sample', '東京', '池袋')
    create_store('sample', '埼玉', '秩父')
    stores = StoreService.find(SearchWord.new(nil))
    expect(stores.size).to eq 2
  end
end
