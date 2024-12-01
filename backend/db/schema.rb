# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_01_063113) do
  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "store_name", null: false
    t.string "prostitute_name", null: false
    t.string "comment", null: false
    t.date "publication_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prostitute_name", "store_name"], name: "index_comments_on_prostitute_name_and_store_name"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id"
    t.text "value"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_show", default: true, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "store1_id"
    t.bigint "store2_id"
    t.index ["store1_id"], name: "index_rooms_on_store1_id"
    t.index ["store2_id"], name: "index_rooms_on_store2_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "stores", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "store_name", null: false
    t.string "prefecture", null: false
    t.string "municipality", null: false
    t.text "home_page", null: false
    t.text "store_image"
    t.string "open_from"
    t.string "open_to"
    t.integer "data_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "messages", "rooms"
  add_foreign_key "rooms", "stores", column: "store1_id"
  add_foreign_key "rooms", "stores", column: "store2_id"
  add_foreign_key "rooms", "users"
end
