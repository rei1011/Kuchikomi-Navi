# frozen_string_literal: true

require 'mechanize'
require 'nokogiri'

class StoresController < ApplicationController # rubocop:disable Style/Documentation
  def index
    # stores = []
    # agent = Mechanize.new
    # page = agent.get('https://fujoho.jp/index.php?p=shop_list&w=M%E6%80%A7%E6%84%9F')
    # doc = Nokogiri::HTML.parse(page.body)

    # doc.css('section.shop.kyokuwari.adrank110').each_with_index do |shop, index|
    #   store_name = shop.css('.shop_header_info_shopname').children.text
    #   store_image = shop.css('.shop_body_photo_list_item_link_img')[0]
    #                     &.attr('data-original')

    #   store_link = shop.css('.shop_header_info_shopname')[0][:href]
    #   shop_info = agent.get(store_link)
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
    #     home_page:,
    #     store_image:
    #   }
    #   stores.push(store)
    # end

    stores = [
      {
        "id": 0,
        "store_name": '西川口前立腺研究所',
        "address": {
          "prefecture": '埼玉',
          "municipality": '西川口'
        },
        "home_page": 'https://www.nk-zenken.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_33161_5e057b1fc97735.00376143.jpg'
      },
      {
        "id": 1,
        "store_name": '五反田アンジェリーク',
        "address": {
          "prefecture": '東京',
          "municipality": '五反田'
        },
        "home_page": 'http://www.gt-ange.club/index.shtml',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_19841_663109a6ad1c71.64754448.jpg'
      },
      {
        "id": 2,
        "store_name": 'うちの看護師にできることと言ったら・・・in渋谷KANGO',
        "address": {
          "prefecture": '東京',
          "municipality": '渋谷'
        },
        "home_page": 'https://www.shibuya-kango.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_4312_641544c2e4a4f8.78741111.jpg'
      },
      {
        "id": 3,
        "store_name": 'ロリ性感と痴女教師 池袋ちんぐり学園',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://www.ik-tingurigakuen.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_47639_62a95b3d20a9c2.71345236.jpg'
      },
      {
        "id": 4,
        "store_name": '逆痴漢',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://gyakuchikan.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_33069_60d9c56cd4ada0.03679468.jpg'
      },
      {
        "id": 5,
        "store_name": '高輪AQUA',
        "address": {
          "prefecture": '東京',
          "municipality": '五反田'
        },
        "home_page": 'https://21aqua.net/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_915_60de1d29824b52.93300076.jpg'
      },
      {
        "id": 6,
        "store_name": '御奉仕関係 -淑女の秘め事-',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'http://www.gohoushi.net/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_340_5f02967e975414.56178075.jpg'
      },
      {
        "id": 7,
        "store_name": '痴女M性感ボランジェ池袋',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://bollinger-m.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_59390_661785768a44f5.56471091.jpg'
      },
      {
        "id": 8,
        "store_name": 'フェティッシュ性感レジーナ',
        "address": {
          "prefecture": '東京',
          "municipality": '新橋'
        },
        "home_page": 'https://ginza-regina.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_604a2f36532f11.66443356_480x640.jpg'
      },
      {
        "id": 9,
        "store_name": '池袋パンスト性感倶楽部',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://www.panst-club.com/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_64c50e82978b95.26910664_480x640.jpg'
      },
      {
        "id": 10,
        "store_name": '絶対服従！闇鍋会 錦糸町店',
        "address": {
          "prefecture": '東京',
          "municipality": '錦糸町'
        },
        "home_page": 'https://yaminabekai.com/kinshicho/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_45395_66322fb38573d4.80853682.jpg'
      },
      {
        "id": 11,
        "store_name": 'ビザールクリニック',
        "address": {
          "prefecture": '東京',
          "municipality": '日暮里'
        },
        "home_page": 'https://www.bizakuri.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_1714_6402e2846f0f85.71279656.jpg'
      },
      {
        "id": 12,
        "store_name": 'ドスケベ痴女回春悶絶Ｍ男塾',
        "address": {
          "prefecture": '東京',
          "municipality": '蒲田'
        },
        "home_page": 'https://www.k-mjuku.net/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_61bc998b41f239.91716694_480x640.jpg'
      },
      {
        "id": 13,
        "store_name": '谷町人妻ゴールデン倶楽部',
        "address": {
          "prefecture": '大阪',
          "municipality": '谷町九丁目'
        },
        "home_page": 'https://www.goldenclub.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_5181_65685c194acf45.84000361.jpg'
      },
      {
        "id": 14,
        "store_name": '快楽園 大阪梅田',
        "address": {
          "prefecture": '大阪',
          "municipality": '梅田'
        },
        "home_page": 'https://www.kairakuen-osaka.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_52244_63c3a263ec20c2.33508796.jpg'
      },
      {
        "id": 15,
        "store_name": '玉乱☆痴（たまらんち）',
        "address": {
          "prefecture": '東京',
          "municipality": '鶯谷'
        },
        "home_page": 'https://www.tamaranchi.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_3964_64ce5cecc38e15.35384346.jpg'
      },
      {
        "id": 16,
        "store_name": '性の極み 技の伝道師 ver. 匠',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://se-den-kiwami.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_46477_624ad126605a89.79749696.jpg'
      },
      {
        "id": 17,
        "store_name": 'C.C.CATS',
        "address": {
          "prefecture": '東京',
          "municipality": '渋谷'
        },
        "home_page": 'https://www.m-seikan.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_952_65e1cae08f6d39.51602180.jpg'
      },
      {
        "id": 18,
        "store_name": 'ビタミンゴールド',
        "address": {
          "prefecture": '東京',
          "municipality": '神田'
        },
        "home_page": 'https://kanda-v.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_39137_626f7b529a7677.85742130.jpg'
      },
      {
        "id": 19,
        "store_name": '痴女のオイルエステすごいんです',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://www.oilesteike.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_65532_663f3f072c10b2.09779500.jpg'
      },
      {
        "id": 20,
        "store_name": 'Unmoral～アンモラル～',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://www.unmoral.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_6318a758de9567.71826189_480x640.jpg'
      },
      {
        "id": 21,
        "store_name": 'やみつきの館　鶯谷店',
        "address": {
          "prefecture": '東京',
          "municipality": '鶯谷'
        },
        "home_page": 'https://yamituki-uguisudani.com/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_6610c2b7581884.42166206_480x640.jpg'
      },
      {
        "id": 22,
        "store_name": '男の潮吹き専門店 五反田回春堂',
        "address": {
          "prefecture": '東京',
          "municipality": '五反田'
        },
        "home_page": 'https://xn--w8j5c378k8zwsbg.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_30211_662bf3e64c4981.80090819.jpg'
      },
      {
        "id": 23,
        "store_name": '変態素人嬢ダダモーレ',
        "address": {
          "prefecture": '東京',
          "municipality": '神田'
        },
        "home_page": 'https://dadamore.deliweb.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_636d84f75f8c18.94043909_480x640.jpg'
      },
      {
        "id": 24,
        "store_name": '東京M性感痴女倶楽部S',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://www.tokyo-mseikan-chijoclub.com/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_651bf277a64e78.04887618_480x640.jpg'
      },
      {
        "id": 25,
        "store_name": '淫乱素人Ｍ性感倶楽部',
        "address": {
          "prefecture": '東京',
          "municipality": '新大久保'
        },
        "home_page": 'https://mseikanclub.deliweb.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_6641f1e2353c62.16589606_480x640.jpg'
      },
      {
        "id": 26,
        "store_name": 'GLACIAS（グラシアス）',
        "address": {
          "prefecture": '東京',
          "municipality": '新宿・歌舞伎町'
        },
        "home_page": 'https://zero-ravel.com/glacias/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_45655_65bc5c67bc2380.33229414.jpg'
      },
      {
        "id": 27,
        "store_name": '変態素人嬢ダダモーレ弐号店',
        "address": {
          "prefecture": '東京',
          "municipality": '池袋'
        },
        "home_page": 'https://dadamore2nd.deliweb.jp/',
        "store_image": 'https://img.fujoho.jp/public/img_girl/girl_662b0eb1359f15.75590434_480x640.jpg'
      },
      {
        "id": 28,
        "store_name": 'THE SECRET（五反田）',
        "address": {
          "prefecture": '東京',
          "municipality": '五反田'
        },
        "home_page": 'https://www.the-secret.group/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_64512_660283c5020a67.09815047.jpg'
      },
      {
        "id": 29,
        "store_name": 'M-TIME',
        "address": {
          "prefecture": '東京',
          "municipality": '鶯谷'
        },
        "home_page": 'https://www.deli-m-time.com/',
        "store_image": 'https://img.fujoho.jp/public/img_shop_list_ad_img/slai_63626_645c7c2b5cd6a4.07161199.jpg'
      }
    ]

    render(json: stores)
  end
end
