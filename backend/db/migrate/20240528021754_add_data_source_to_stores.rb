class AddDataSourceToStores < ActiveRecord::Migration[7.1]
  def change
    add_column :stores, :data_source, :integer, after: :open_to
  end
end
