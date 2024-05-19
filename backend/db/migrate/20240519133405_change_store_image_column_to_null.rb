class ChangeStoreImageColumnToNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :stores, :store_image, true
  end
end
