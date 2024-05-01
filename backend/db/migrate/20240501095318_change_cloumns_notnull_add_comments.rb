class ChangeCloumnsNotnullAddComments < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :store_name, false
    change_column_null :comments, :prostitute_name, false
    change_column_null :comments, :comment, false
    change_column_null :comments, :publication_date, false
  end
end
