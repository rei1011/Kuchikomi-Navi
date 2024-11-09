class AddStoreIdToRooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :rooms, :store1, foreign_key: {to_table: :stores}, null: true
    add_reference :rooms, :store2, foreign_key: {to_table: :stores}, null: true
  end
end
