# frozen_string_literal: true

# == Schema Information
#
# Table name: stores
#
#  id           :bigint           not null, primary key
#  store_name   :string(255)      not null
#  prefecture   :string(255)      not null
#  municipality :string(255)      not null
#  home_page    :text(65535)      not null
#  store_image  :text(65535)
#  open_from    :string(255)
#  open_to      :string(255)
#  data_source  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Store, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
