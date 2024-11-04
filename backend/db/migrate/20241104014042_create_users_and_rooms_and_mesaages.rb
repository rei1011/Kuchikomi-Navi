class CreateUsersAndRoomsAndMesaages < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.timestamps
    end

    create_table :rooms do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.timestamps
    end

    create_table :messages do |t|
      t.belongs_to :room, foreign_key: true
      t.string :message
      t.integer :role
      t.timestamps
    end
  end
end
