class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :store_name
      t.string :prostitute_name
      t.string :comment
      t.date :publication_date

      t.timestamps
    end
  end
end
