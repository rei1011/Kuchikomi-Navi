# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

class StoresController < ApplicationController # rubocop:disable Style/Documentation
  def index
    # stores = []
    # agent = Mechanize.new
    # page = agent.get('https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F')
    # doc = Nokogiri::HTML.parse(page.body)

    # doc.css('.shop_header_info_shopname').each_with_index do |shop, index|
    #   store_name = shop.children.text
    #   shop_info = agent.get(shop[:href])
    #   shop_doc = Nokogiri::HTML.parse(shop_info.body)
    #   home_page = shop_doc.css('.side_iframe_shell')[1][:href]
    #   address = shop_doc.css('.nav_pankuzu_list_item_inner')
    #   prefecture = address[1].children.children.text.delete('風俗')
    #   municipality = address[2].children.children.text.delete('風俗')

    #   store = {
    #     id: index,
    #     store_name:,
    #     address: {
    #       prefecture:,
    #       municipality:
    #     },
    #     home_page:
    #   }
    #   stores.push(store)
    # end

    stores = [
      { "id": 0, "store_name": '西川口前立腺研究所', "address": { "prefecture": '埼玉', "municipality": '西川口' },
        "home_page": 'https://www.nk-zenken.com/' }, { "id": 1, "store_name": '五反田アンジェリーク', "address": { "prefecture": '東京', "municipality": '五反田' }, "home_page": 'http://www.gt-ange.club/index.shtml' }, { "id": 2, "store_name": 'うちの看護師にできることと言ったら・・・in渋谷KANGO', "address": { "prefecture": '東京', "municipality": '渋谷' }, "home_page": 'https://www.shibuya-kango.com/' }, { "id": 3, "store_name": 'ロリ性感と痴女教師 池袋ちんぐり学園', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://www.ik-tingurigakuen.com/' }, { "id": 4, "store_name": '逆痴漢', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://gyakuchikan.jp/' }, { "id": 5, "store_name": '高輪AQUA', "address": { "prefecture": '東京', "municipality": '五反田' }, "home_page": 'https://21aqua.net/' }, { "id": 6, "store_name": '御奉仕関係 -淑女の秘め事-', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'http://www.gohoushi.net/' }, { "id": 7, "store_name": '痴女M性感ボランジェ池袋', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://bollinger-m.com/' }, { "id": 8, "store_name": 'フェティッシュ性感レジーナ', "address": { "prefecture": '東京', "municipality": '新橋' }, "home_page": 'https://ginza-regina.jp/' }, { "id": 9, "store_name": '池袋パンスト性感倶楽部', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://www.panst-club.com/' }, { "id": 10, "store_name": '絶対服従！闇鍋会 錦糸町店', "address": { "prefecture": '東京', "municipality": '錦糸町' }, "home_page": 'https://yaminabekai.com/kinshicho/' }, { "id": 11, "store_name": 'ビザールクリニック', "address": { "prefecture": '東京', "municipality": '日暮里' }, "home_page": 'https://www.bizakuri.com/' }, { "id": 12, "store_name": 'ドスケベ痴女回春悶絶Ｍ男塾', "address": { "prefecture": '東京', "municipality": '蒲田' }, "home_page": 'https://www.k-mjuku.net/' }, { "id": 13, "store_name": '谷町人妻ゴールデン倶楽部', "address": { "prefecture": '大阪', "municipality": '谷町九丁目' }, "home_page": 'https://www.goldenclub.jp/' }, { "id": 14, "store_name": '快楽園 大阪梅田', "address": { "prefecture": '大阪', "municipality": '梅田' }, "home_page": 'https://www.kairakuen-osaka.com/' }, { "id": 15, "store_name": '玉乱☆痴（たまらんち）', "address": { "prefecture": '東京', "municipality": '鶯谷' }, "home_page": 'https://www.tamaranchi.com/' }, { "id": 16, "store_name": '性の極み 技の伝道師 ver. 匠', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://se-den-kiwami.com/' }, { "id": 17, "store_name": 'C.C.CATS', "address": { "prefecture": '東京', "municipality": '渋谷' }, "home_page": 'https://www.m-seikan.com/' }, { "id": 18, "store_name": 'ビタミンゴールド', "address": { "prefecture": '東京', "municipality": '神田' }, "home_page": 'https://kanda-v.com/' }, { "id": 19, "store_name": '痴女のオイルエステすごいんです', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://www.oilesteike.com/' }, { "id": 20, "store_name": '梅田人妻秘密倶楽部', "address": { "prefecture": '大阪', "municipality": '梅田' }, "home_page": 'https://www.umedahimitu.net/' }, { "id": 21, "store_name": '谷町秘密倶楽部', "address": { "prefecture": '大阪', "municipality": '谷町九丁目' }, "home_page": 'https://www.himitu.org/' }, { "id": 22, "store_name": '梅田ゴールデン倶楽部', "address": { "prefecture": '大阪', "municipality": '梅田' }, "home_page": 'https://www.63158888.com/' }, { "id": 23, "store_name": 'Unmoral～アンモラル～', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://www.unmoral.jp/' }, { "id": 24, "store_name": '池袋西口でSUGEEE求められる俺のカラダ', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://orenokarada.com/' }, { "id": 25, "store_name": 'やみつきの館　鶯谷店', "address": { "prefecture": '東京', "municipality": '鶯谷' }, "home_page": 'https://yamituki-uguisudani.com/' }, { "id": 26, "store_name": '男の潮吹き専門店 五反田回春堂', "address": { "prefecture": '東京', "municipality": '五反田' }, "home_page": 'https://xn--w8j5c378k8zwsbg.jp/' }, { "id": 27, "store_name": '変態素人嬢ダダモーレ', "address": { "prefecture": '東京', "municipality": '神田' }, "home_page": 'https://dadamore.deliweb.jp/' }, { "id": 28, "store_name": '東京M性感痴女倶楽部S', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://www.tokyo-mseikan-chijoclub.com/' }, { "id": 29, "store_name": '淫乱素人Ｍ性感倶楽部', "address": { "prefecture": '東京', "municipality": '新大久保' }, "home_page": 'https://mseikanclub.deliweb.jp/' }, { "id": 30, "store_name": 'GLACIAS（グラシアス）', "address": { "prefecture": '東京', "municipality": '新宿・歌舞伎町' }, "home_page": 'https://zero-ravel.com/glacias/' }, { "id": 31, "store_name": '変態素人嬢ダダモーレ弐号店', "address": { "prefecture": '東京', "municipality": '池袋' }, "home_page": 'https://dadamore2nd.deliweb.jp/' }, { "id": 32, "store_name": 'THE SECRET（五反田）', "address": { "prefecture": '東京', "municipality": '五反田' }, "home_page": 'https://www.the-secret.group/' }, { "id": 33, "store_name": 'M-TIME', "address": { "prefecture": '東京', "municipality": '鶯谷' }, "home_page": 'https://www.deli-m-time.com/' }
    ]

    render(json: stores)
  end
end
