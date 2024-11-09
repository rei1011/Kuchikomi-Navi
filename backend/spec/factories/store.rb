# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    store_name { 'sample' }
    prefecture { '東京' }
    municipality { '池袋' }
    home_page { 'https://sample.co.jp' }
    store_image { 'https://sample.co.jp' }
    open_from { '10:00' }
    open_to { '18:00' }
  end
end
