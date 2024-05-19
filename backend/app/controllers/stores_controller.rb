# frozen_string_literal: true

class StoresController < ApplicationController # rubocop:disable Style/Documentation
  def index
    stores = []
    Store.all.each do |store|
      stores.push({
                    id: store[:id],
                    store_name: store[:store_name],
                    address: {
                      prefecture: store[:prefecture],
                      municipality: store[:municipality]
                    },
                    home_page: store[:home_page],
                    store_image: store[:store_image]
                  })
    end

    render(json: stores)
  end
end
