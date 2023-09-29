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

ActiveRecord::Schema[7.0].define(version: 2023_09_29_171643) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "browsing_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_browsing_histories_on_item_id"
    t.index ["user_id"], name: "index_browsing_histories_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "user_1_id", null: false
    t.bigint "user_2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_1_id"], name: "index_conversations_on_user_1_id"
    t.index ["user_2_id"], name: "index_conversations_on_user_2_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_favourites_on_item_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "item_comments", force: :cascade do |t|
    t.text "content"
    t.bigint "item_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_comments_on_item_id"
    t.index ["user_id"], name: "index_item_comments_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.integer "swapzi_points"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "swap_counter"
    t.boolean "hidden", default: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "timestamp", precision: nil
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conversation_id", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "swaps", force: :cascade do |t|
    t.date "date_initiated"
    t.date "date_completed"
    t.boolean "accepted_user_1"
    t.boolean "accepted_user_2"
    t.boolean "completed_user_1"
    t.boolean "completed_user_2"
    t.boolean "completed"
    t.bigint "user_1_id", null: false
    t.bigint "user_2_id", null: false
    t.bigint "item_1_id", null: false
    t.bigint "item_2_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_1_id"], name: "index_swaps_on_item_1_id"
    t.index ["item_2_id"], name: "index_swaps_on_item_2_id"
    t.index ["user_1_id"], name: "index_swaps_on_user_1_id"
    t.index ["user_2_id"], name: "index_swaps_on_user_2_id"
  end

  create_table "user_reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.bigint "swap_id", null: false
    t.bigint "reviewer_id", null: false
    t.bigint "reviewed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewed_id"], name: "index_user_reviews_on_reviewed_id"
    t.index ["reviewer_id"], name: "index_user_reviews_on_reviewer_id"
    t.index ["swap_id"], name: "index_user_reviews_on_swap_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "location"
    t.integer "swapzi_score"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "browsing_histories", "items"
  add_foreign_key "browsing_histories", "users"
  add_foreign_key "conversations", "users", column: "user_1_id"
  add_foreign_key "conversations", "users", column: "user_2_id"
  add_foreign_key "favourites", "items"
  add_foreign_key "favourites", "users"
  add_foreign_key "item_comments", "items"
  add_foreign_key "item_comments", "users"
  add_foreign_key "items", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "swaps", "items", column: "item_1_id"
  add_foreign_key "swaps", "items", column: "item_2_id"
  add_foreign_key "swaps", "users", column: "user_1_id"
  add_foreign_key "swaps", "users", column: "user_2_id"
  add_foreign_key "user_reviews", "swaps"
  add_foreign_key "user_reviews", "users", column: "reviewed_id"
  add_foreign_key "user_reviews", "users", column: "reviewer_id"
end
