# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreListDomain do
  def create_store(prefecture, home_page)
    StoreDomain.new(store_name: '東京店',
                    prefecture:,
                    municipality: '池袋',
                    store_image: 'https://sample.co.jp',
                    home_page:,
                    open_hours: OpenHours.new(from: '10:00', to: '19:00'),
                    data_source: DataSource.new(DataSource::UNKNOWN))
  end
  it 'find by prefecture name' do
    store1 = create_store('東京', 'https://sample.co.jp')
    store2 = create_store('埼玉', 'https://sample.co.jp')
    store_list = StoreListDomain.new([store1, store2])
    selected_store_list = store_list.find_by_prefecture(%w[東京 千葉])
    expect(selected_store_list.list.size).to eq 1
    expect(selected_store_list.list[0].address.prefecture).to eq '東京'
  end

  it 'If there is no corresponding store' do
    store1 = create_store('東京', 'https://sample.co.jp')
    store2 = create_store('埼玉', 'https://sample.co.jp')
    store_list = StoreListDomain.new([store1, store2])
    selected_store_list = store_list.find_by_prefecture(['千葉'])
    expect(selected_store_list.list.size).to eq 0
  end

  it '店舗の重複を除外する' do
    store1 = create_store('東京', 'https://sample.co.jp')
    store2 = create_store('東京', 'https://sample.co.jp')
    store_list = StoreListDomain.new([store1, store2])
    expect(store_list.uniq.list.size).to eq 1
  end
end
