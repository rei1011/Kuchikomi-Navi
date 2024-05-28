# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

# 風俗じゃぱん！から店舗情報を取得する
class FuzokuService
  class << self
    def find
      stores = []
      prefectures = %w[kanagawa tokyo]
      prefectures.each do |area|
        i = 0
        loop do
          list = find_store_info(i.zero? ? '/' : "/page#{i + 1}/", area)
          stores.push(*list)
          i += 1
          break if list.size == 0 # rubocop:disable Style/NumericPredicate,Style/ZeroLengthPredicate
        end
      end

      StoreListDomain.new(stores)
    end

    private

    def find_store_info(page_path, area) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      stores = []
      agent = Mechanize.new
      begin
        page = agent.get("https://fuzoku.jp/#{area}/ge_14#{page_path}")
      rescue Mechanize::ResponseCodeError => e
        # 404の場合はこれ以上店舗情報がないことを意味しているので、空のstoresを返却する
        return stores if e.response_code == '404'

        raise e
      end

      doc = Nokogiri::HTML.parse(page.body)
      doc.css('.shopList__item.p-shopItem').each do |shop|
        store_link = shop.css('.shopItem__shopName').css('a').attr('href').value
        store_page = agent.get(store_link)
        store_doc = Nokogiri::HTML.parse(store_page.body)
        home_page = store_doc.css('.shop-hp').attr('href').value
        # M性感のお店でない場合はスキップする
        next unless m_sexual_feeling(store_doc)

        store_name = shop.css('.shopItem__shopName').css('a').children.text
        store_image = shop.css('.shopItem__thumbnail')&.attr('data-original')&.value
        prefecture = area == 'tokyo' ? '東京' : '神奈川'
        municipality = shop.attr('data-selectshopmainarea')
        open = shop.css('.shopItem__dataItem--open').text.presence || shop.css('.shopItem__dataItem')[1].text

        stores.push(StoreDomain.new(
                      store_name:,
                      store_image:,
                      home_page:,
                      prefecture:,
                      municipality:,
                      open_hours: OpenHours.from_time_str(open),
                      data_source: DataSource.new(DataSource::FUZOKU)
                    ))
      end
      stores
    end

    def m_sexual_feeling(store_doc)
      patterns = /アナル|前立腺|Mプレイ|エネマグラ/
      nodes = store_doc.xpath('//text()')
      nodes.any? { |node| node.content =~ patterns }
    end
  end
end
