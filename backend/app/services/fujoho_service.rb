# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

class FujohoService # rubocop:disable Style/Documentation
  class << self
    def get # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      stores = []
      agent = Mechanize.new
      page = agent.get('https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F&b=0')
      doc = Nokogiri::HTML.parse(page.body)

      doc.css('section.shop.adrank110').each do |shop|
        store_name = shop.css('.shop_header_info_shopname').children.text
        store_image = shop.css('.shop_body_photo_list_item_link_img')[0].attr('data-original')
        shop_info = agent.get(shop.css('.shop_header_info_shopname')[0][:href]).body
        home_page, prefecture, municipality = get_store_info(shop_info)

        stores.push(Store.new(store_name:, prefecture:, municipality:, home_page:, store_image:))
      end

      doc.css('section.shop.adrank50,.adrank10,.adrank5').each do |shop|
        store_name = shop.css('.header').css('h2').css('a').children.text
        store_image = shop.css('.shop_list_ad_img').attr('data-original')&.value ||
                      shop.css('.shop_girl')[0].css('img').attr('data-original').value
        shop_info = agent.get(shop.css('.header').css('h2').css('a').attr('href').value).body
        home_page, prefecture, municipality = get_store_info(shop_info)

        stores.push(Store.new(store_name:, prefecture:, municipality:, home_page:, store_image:))
      end

      stores
    end

    private

    def get_store_info(shop_html)
      shop_doc = Nokogiri::HTML.parse(shop_html)
      home_page = shop_doc.css('.side_iframe_shell')[1][:href]
      address = shop_doc.css('.nav_pankuzu_list_item_inner')
      prefecture = address[1].children.children.text.delete('風俗')
      municipality = address[2].children.children.text.delete('風俗')

      [home_page, prefecture, municipality]
    end
  end
end
