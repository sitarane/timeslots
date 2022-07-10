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

ActiveRecord::Schema[7.0].define(version: 2022_07_10_165105) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "slot_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slot_id"], name: "index_bookings_on_slot_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "calendar_assignations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "calendar_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_calendar_assignations_on_calendar_id"
    t.index ["user_id"], name: "index_calendar_assignations_on_user_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "advance_warning", default: 0, null: false
    t.boolean "public", default: true
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "calendar_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_invitations_on_calendar_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "description"
    t.datetime "start_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_id", null: false
    t.integer "winner"
    t.index ["calendar_id"], name: "index_slots_on_calendar_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "slots"
  add_foreign_key "bookings", "users"
  add_foreign_key "calendar_assignations", "calendars"
  add_foreign_key "calendar_assignations", "users"
  add_foreign_key "invitations", "calendars"
  add_foreign_key "invitations", "users"
  add_foreign_key "slots", "calendars"
end
