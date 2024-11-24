class RenameMessageColumnToMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :message, :value
  end
end
