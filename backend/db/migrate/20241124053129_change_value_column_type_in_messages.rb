class ChangeValueColumnTypeInMessages < ActiveRecord::Migration[7.1]
  def change
    change_column :messages, :value, :text
  end
end
