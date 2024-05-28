# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

class FujohoService # rubocop:disable Style/Documentation
  class << self
    def find
      stores = []
      i = 0
      loop do
        list = find_store_info(i)
        stores.push(*list)
        i += 1
        break if list.size == 0 # rubocop:disable Style/NumericPredicate,Style/ZeroLengthPredicate
      end
      StoreListDomain.new(stores).find_by_prefecture(%w[東京 神奈川])
    end

    private

    def find_store_info(index) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      stores = []
      agent = Mechanize.new
      page = agent.get("https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F&b=#{index}")
      doc = Nokogiri::HTML.parse(page.body)

      doc.css('section.shop.adrank110').each do |shop|
        store_name = shop.css('.shop_header_info_shopname').children.text
        store_image = shop.css('.shop_body_photo_list_item_link_img')[0].attr('data-original')
        shop_info = agent.get(shop.css('.shop_header_info_shopname')[0][:href]).body
        home_page, prefecture, municipality = find_store_detail(shop_info)
        open = shop.css('.shop_header_info_time').children.text

        stores.push(StoreDomain.new(store_name:, prefecture:, municipality:, home_page:, store_image:,
                                    open_hours: OpenHours.from_time_str(open), data_source: DataSource.new(DataSource::FUJOHO)))
      end

      doc.css('section.shop.adrank50,.adrank10,.adrank5,.adrank0').each do |shop|
        store_name = shop.css('.header').css('h2').css('a').children.text
        store_image = shop.css('.shop_list_ad_img')&.attr('data-original')&.value ||
                      shop.css('.shop_girl')[0]&.css('img')&.attr('data-original')&.value ||
                      nil
        shop_info = agent.get(shop.css('.header').css('h2').css('a').attr('href').value).body
        home_page, prefecture, municipality = find_store_detail(shop_info)
        open = shop.css('.open_time').children.text

        stores.push(StoreDomain.new(store_name:, prefecture:, municipality:, home_page:, store_image:,
                                    open_hours: OpenHours.from_time_str(open), data_source: DataSource.new(DataSource::FUJOHO)))
      end

      stores
    end

    def find_store_detail(shop_html)
      shop_doc = Nokogiri::HTML.parse(shop_html)
      home_page = shop_doc.css('.side_iframe_shell')[1][:href]
      address = shop_doc.css('.nav_pankuzu_list_item_inner')
      prefecture = address[1].children.children.text.delete('風俗')
      municipality = address[2].children.children.text.delete('風俗')

      [home_page, prefecture, municipality]
    end
  end
end
