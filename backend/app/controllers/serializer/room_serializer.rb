# frozen_string_literal: true

class RoomSerializer < Blueprinter::Base # rubocop:disable Style/Documentation
  identifier :id
  fields :name
  field :store1, unless: ->(_field_name, room, _options) { room.store1.nil? } do |room|
    StoreSerializer.render_as_hash(room.store1)
  end
  field :store2, unless: ->(_field_name, room, _options) { room.store2.nil? } do |room|
    StoreSerializer.render_as_hash(room.store2)
  end
end
