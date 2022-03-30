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

ActiveRecord::Schema[7.0].define(version: 2022_03_30_202608) do
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

  create_table "calendar_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "calendar_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_calendar_assignments_on_calendar_id"
    t.index ["user_id"], name: "index_calendar_assignments_on_user_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "advance_warning"
  end

  create_table "calendars_users", id: false, force: :cascade do |t|
    t.bigint "calendar_id"
    t.bigint "user_id"
    t.index ["calendar_id"], name: "index_calendars_users_on_calendar_id"
    t.index ["user_id"], name: "index_calendars_users_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "start_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "calendar_id", null: false
    t.index ["calendar_id"], name: "index_slots_on_calendar_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "slots"
  add_foreign_key "bookings", "users"
  add_foreign_key "slots", "calendars"
end
