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
  belongs_to :store1, class_name: 'Store', optional: true
  belongs_to :store2, class_name: 'Store', optional: true
  has_many :messages, dependent: :destroy
end
