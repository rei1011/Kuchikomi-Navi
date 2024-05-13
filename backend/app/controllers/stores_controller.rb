# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

class StoresController < ApplicationController # rubocop:disable Style/Documentation
  def index
    stores = []
    hoge = []
    agent = Mechanize.new
    page = agent.get('https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F')
    doc = Nokogiri::HTML.parse(page.body)

    doc.css('.shop_header_info_shopname').each_with_index do |shop, index|
      store_name = shop.children.text
      shop_info = agent.get(shop[:href])
      shop_doc = Nokogiri::HTML.parse(shop_info.body)
      home_page = shop_doc.css('.side_iframe_shell')[1][:href]
      address = shop_doc.css('.nav_pankuzu_list_item_inner')
      prefecture = address[1].children.children.text.delete('風俗')
      municipality = address[2].children.children.text.delete('風俗')

      store = {
        id: index,
        store_name:,
        address: {
          prefecture:,
          municipality:
        },
        home_page:
      }
      hoge.push(store)
    end

    render(json: stores)
  end
end
