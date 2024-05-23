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
        # p "get store_link = #{store_link}"
        # p 'agent.get start'
        store_page = agent.get(store_link)
        # p 'agent.get end'
        store_doc = Nokogiri::HTML.parse(store_page.body)

        # p 'parse end'
        home_page = store_doc.css('.shop-hp').attr('href').value
        # p "get home_page = #{home_page}"
        next unless m_sexual_feeling(store_doc)

        # p "#{page_path} #{area}"
        store_name = shop.css('.shopItem__shopName').css('a').children.text
        # p "get store_name = #{store_name}"
        store_image = shop.css('.shopItem__thumbnail')&.attr('data-original')&.value
        # p "get store_image = #{store_image}"
        prefecture = '東京'
        municipality = shop.attr('data-selectshopmainarea')
        # p "get municipality = #{municipality}"

        stores.push(StoreDomain.new(
                      store_name:,
                      store_image:,
                      home_page:,
                      prefecture:,
                      municipality:
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
