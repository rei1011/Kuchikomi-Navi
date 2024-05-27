class AddOpenTimeToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :open_to, :string, after: :store_image
    add_column :stores, :open_from, :string, after: :store_image
  end
end
