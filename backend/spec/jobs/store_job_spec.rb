# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StoreJob' do # rubocop:disable Metrics/BlockLength
  def mock_fujoho_service
    # 一件の店舗情報が見つかったと仮定する
    allow(FujohoService).to receive(:find).and_return(StoreListDomain.new(
                                                        [
                                                          StoreDomain.new(id: nil,
                                                                          store_name: 'sample store 1',
                                                                          prefecture: 'sample prefecture',
                                                                          municipality: 'sample municipality',
                                                                          home_page: 'https://sample.co.jp',
                                                                          store_image: 'https://sample.co.jp/sample.jpg',
                                                                          open_hours: OpenHours.new(
                                                                            from: '10:00', to: '19:00'
                                                                          ),
                                                                          data_source: DataSource.new(DataSource::UNKNOWN))
                                                        ]
                                                      ))
  end

  def mock_fuzoku_service
    # 一件の店舗情報が見つかったと仮定する
    allow(FuzokuService).to receive(:find).and_return(StoreListDomain.new(
                                                        [
                                                          StoreDomain.new(id: 1,
                                                                          store_name: 'sample store 1',
                                                                          prefecture: 'sample prefecture',
                                                                          municipality: 'sample municipality',
                                                                          home_page: 'https://sample.co.jp',
                                                                          store_image: 'https://sample.co.jp/sample.jpg',
                                                                          open_hours: OpenHours.new(
                                                                            from: '10:00', to: '19:00'
                                                                          ),
                                                                          data_source: DataSource.new(DataSource::UNKNOWN))
                                                        ]
                                                      ))
  end

  def mock_empty_fuzoku_service
    # 一件の店舗情報が見つかったと仮定する
    allow(FuzokuService).to receive(:find).and_return(
      StoreListDomain.new([])
    )
  end

  it 'If store information exists, it will be saved.' do
    mock_fujoho_service
    mock_empty_fuzoku_service
    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end

  it 'Idempotency is guaranteed' do
    mock_fujoho_service
    mock_empty_fuzoku_service
    StoreJob.perform
    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end

  it 'the data will be rolled back if the job fails.' do
    # 何かしらのエラーが発生したとする
    allow(FujohoService).to receive(:find).and_raise(StandardError)
    mock_empty_fuzoku_service

    # 事前に一件データを挿入する
    Store.create(
      store_name: 'sample store 1',
      prefecture: 'sample prefecture',
      municipality: 'sample municipality',
      home_page: 'https://sample.co.jp',
      store_image: 'https://sample.co.jp/sample.jpg'
    )

    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end

  it '店舗情報を重複なく取得できる' do
    mock_fujoho_service
    mock_fuzoku_service
    StoreJob.perform
    expect(Store.all.size).to(eq(1))
  end
end
