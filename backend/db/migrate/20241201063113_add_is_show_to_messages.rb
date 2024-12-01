class AddIsShowToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :is_show, :boolean, default: true, null: false
  end
end
