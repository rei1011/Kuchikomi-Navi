# frozen_string_literal: true

class StoreSerializer < Blueprinter::Base # rubocop:disable Style/Documentation
  identifier :id

  field :store_name, name: :name
end
