class IndexAddComments < ActiveRecord::Migration[7.1]
  def change
    add_index :comments, [:prostitute_name, :store_name]
  end
end
