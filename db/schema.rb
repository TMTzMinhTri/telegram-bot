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

ActiveRecord::Schema[7.2].define(version: 2025_02_21_082039) do
  create_table "court_booking_players", force: :cascade do |t|
    t.integer "court_booking_id", null: false
    t.integer "player_id"
    t.string "name"
    t.integer "invited_by_id"
    t.integer "played_minutes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["court_booking_id"], name: "index_court_booking_players_on_court_booking_id"
    t.index ["invited_by_id"], name: "index_court_booking_players_on_invited_by_id"
    t.index ["player_id"], name: "index_court_booking_players_on_player_id"
  end

# Could not dump table "court_bookings" because of following StandardError
#   Unknown type 'uuid' for column 'id'


  create_table "players", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.string "name"
    t.datetime "telegram_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
  end

  add_foreign_key "court_booking_players", "court_bookings"
  add_foreign_key "court_booking_players", "players"
  add_foreign_key "court_booking_players", "players", column: "invited_by_id"
end
