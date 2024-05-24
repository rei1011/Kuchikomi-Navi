# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '風俗じゃぱん！から店舗一覧を取得' do
  it '店舗一覧を取得する' do
    # 店舗詳細のmock
    raw_shop_detail_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_detail_response.txt')
    stub_request(:get, %r{https://fuzoku\.jp/[^/]+/})
      .to_return(status: 200, body: raw_shop_detail_file, headers: { content_type: 'text/html' })

    # 店舗一覧のmock（東京, 1ページ目）
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/')
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })
    # 店舗一覧のmock（東京, 2ページ目）
    raw_shop_list_file_page2 = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/page2/')
      .to_return(status: 200, body: raw_shop_list_file_page2, headers: { content_type: 'text/html' })

    # 店舗一覧（情報なし）のmock（東京, 3ページ目）
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/page3/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    # 店舗一覧のmock（神奈川, 1ページ目）
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/kanagawa/ge_14/')
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })
    # 店舗一覧のmock（神奈川, 2ページ目）
    raw_shop_list_file_page2 = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/kanagawa/ge_14/page2/')
      .to_return(status: 200, body: raw_shop_list_file_page2, headers: { content_type: 'text/html' })

    # 店舗一覧のmock（神奈川, 3ページ目）
    stub_request(:get, 'https://fuzoku.jp/kanagawa/ge_14/page3/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    store_list = FuzokuService.find
    expect(store_list.list.size).to eq 200
  end

  it '店舗一覧画面を表示する際に404が返却されてもエラーは発生しない' do
    # 店舗一覧で404が返却される
    prefectures = %w[tokyo kanagawa]
    prefectures.each do |prefecture|
      stub_request(:get, "https://fuzoku.jp/#{prefecture}/ge_14/")
        .to_return(status: 404, body: 'Not Found', headers: {})
    end
    store_list = FuzokuService.find
    expect(store_list.list.size).to eq 0
  end

  it '店舗一覧画面を表示する際に404以外の異常なstatus codeが返却されたたらエラーが発生する' do
    # 店舗一覧で500が返却される
    prefectures = %w[tokyo kanagawa]
    prefectures.each do |prefecture|
      stub_request(:get, "https://fuzoku.jp/#{prefecture}/ge_14/")
        .to_return(status: 500, body: 'Server Error', headers: {})
    end
    expect do
      FuzokuService.find
    end.to raise_error(Mechanize::ResponseCodeError)
  end

  it 'M性感のお店だけ取得する' do
    # 店舗詳細のmock
    raw_shop_detail_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_detail_response.txt')
    stub_request(:get, %r{https://fuzoku\.jp/[^/]+/})
      .to_return(status: 200, body: raw_shop_detail_file, headers: { content_type: 'text/html' })

    # 店舗一覧のmock（東京, 1ページ目）
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/')
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })
    # 店舗一覧のmock（東京, 2ページ目）
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/page2/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    # 店舗一覧のmock（神奈川, 1ページ目）
    stub_request(:get, 'https://fuzoku.jp/kanagawa/ge_14/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    store_list = FuzokuService.find
    expect(store_list.list.size).to eq 50
  end

  it 'M性感でない場合は取得できない' do
    # 店舗詳細のmock（M性感ではない）
    raw_shop_detail_file = File.new('/usr/src/app/backend/spec/services/fuzoku/no_m_sexual_feeling_shop_detail_response.txt')
    stub_request(:get, %r{https://fuzoku\.jp/[^/]+/})
      .to_return(status: 200, body: raw_shop_detail_file, headers: { content_type: 'text/html' })

    # 店舗一覧のmock（東京, 1ページ目）
    raw_shop_list_file = File.new('/usr/src/app/backend/spec/services/fuzoku/shop_list_response.txt')
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/')
      .to_return(status: 200, body: raw_shop_list_file, headers: { content_type: 'text/html' })
    # 店舗一覧のmock（東京, 2ページ目）
    stub_request(:get, 'https://fuzoku.jp/tokyo/ge_14/page2/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    # 店舗一覧のmock（神奈川, 1ページ目）
    stub_request(:get, 'https://fuzoku.jp/kanagawa/ge_14/')
      .to_return(status: 404, body: 'Not Found', headers: {})

    store_list = FuzokuService.find
    expect(store_list.list.size).to eq 0
  end
end
