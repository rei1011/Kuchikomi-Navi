# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'save store from web page' do
  it 'If store information exists, it will be saved.' do
    # 一件の店舗情報が見つかったと仮定する
    allow(FujohoService).to receive(:get).and_return([Store.new(store_name: 'sample store 1',
                                                                prefecture: 'sample prefecture',
                                                                municipality: 'sample municipality',
                                                                home_page: 'https://sample.co.jp',
                                                                store_image: 'https://sample.co.jp/sample.jpg')])
    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end

  it 'Idempotency is guaranteed' do
    # 一件の店舗情報が見つかったと仮定する
    allow(FujohoService).to receive(:get).and_return([Store.new(store_name: 'sample store 1',
                                                                prefecture: 'sample prefecture',
                                                                municipality: 'sample municipality',
                                                                home_page: 'https://sample.co.jp',
                                                                store_image: 'https://sample.co.jp/sample.jpg')])
    StoreJob.perform
    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end
end
