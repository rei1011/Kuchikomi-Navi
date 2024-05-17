class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false
      t.string :prefecture, null: false
      t.string :municipality, null: false
      t.text :home_page, null: false
      t.text :store_image, null: false

      t.timestamps
    end
  end
end
