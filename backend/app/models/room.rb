# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store1_id  :bigint
#  store2_id  :bigint
#
class Room < ApplicationRecord
  belongs_to :user
end
