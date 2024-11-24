# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  room_id    :bigint
#  message    :string(255)
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
  belongs_to :room
  enum :role, { user: 0, assistant: 1 }
end
