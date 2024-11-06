# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  store_name       :string(255)      not null
#  prostitute_name  :string(255)      not null
#  comment          :string(255)      not null
#  publication_date :date             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Comment < ApplicationRecord
end
