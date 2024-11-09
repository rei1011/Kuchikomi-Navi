# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreRepository do
  def create_store_by_address(prefecture, municipality)
    Store.create(store_name: 'sample',
                 prefecture:,
                 municipality:,
                 store_image: 'https://sample.co.jp',
                 home_page: 'https://sample.co.jp/photo.jpg')
  end

  context 'find_all' do
    it 'find all store' do
      create_store_by_address('東京', '池袋')
      create_store_by_address('東京', '五反田')
      stores = StoreRepository.find_all
      expect(stores.size).to eq 2
    end

    it 'Returns an empty array when there is no store information' do
      stores = StoreRepository.find_all
      expect(stores.size).to eq 0
    end
  end

  context 'find_by_prefecture' do
    it 'find by prefecture name' do
      create_store_by_address('東京', '池袋')
      create_store_by_address('東京', '五反田')
      create_store_by_address('埼玉', '秩父')
      stores = StoreRepository.find_by_prefecture('東京')
      expect(stores.size).to eq 2
      expect(stores[0].address.municipality).to eq '池袋'
      expect(stores[1].address.municipality).to eq '五反田'
    end

    it '県名の部分一致で検索できる' do
      create_store_by_address('東京', '池袋')
      create_store_by_address('埼玉', '秩父')
      stores = StoreRepository.find_by_prefecture('東')
      expect(stores.size).to eq 1
    end

    it 'Returns an empty array when there is no store information' do
      stores = StoreRepository.find_by_prefecture('東京')
      expect(stores.size).to eq 0
    end
  end

  context 'find_by_keyword' do
    def create_store_by_store_name_and_address(store_name, prefecture, municipality)
      Store.create(store_name:,
                   prefecture:,
                   municipality:,
                   store_image: 'https://sample.co.jp',
                   home_page: 'https://sample.co.jp/photo.jpg')
    end

    it do
      create_store_by_store_name_and_address('hoge', 'fuga', 'piyo')
      create_store_by_store_name_and_address('fuga', 'hoge', 'piyo')
      create_store_by_store_name_and_address('piyo', 'fuga', 'hoge')
      stores = StoreRepository.find_by_keyword('ho')
      expect(stores.size).to eq 3
    end

    it 'Returns an empty array when there is no store information' do
      stores = StoreRepository.find_by_keyword('東京')
      expect(stores.size).to eq 0
    end
  end

  context 'find_by_ids' do
    it '複数IDを指定して店舗情報を取得できる' do
      store1 = create_store_by_address('東京', '池袋')
      store2 = create_store_by_address('東京', '五反田')
      create_store_by_address('埼玉', '秩父')
      stores = StoreRepository.find_by_ids([store1.id, store2.id])
      expect(stores.size).to eq 2
      expect(stores[0].address.municipality).to eq '池袋'
      expect(stores[1].address.municipality).to eq '五反田'
    end
  end
end
