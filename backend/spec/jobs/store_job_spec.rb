# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'save store from web page' do
  it 'If store information exists, it will be saved.' do
    StoreJob.perform
    expect(Store.all.size).to eq 1
  end
end
