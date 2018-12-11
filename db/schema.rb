# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_11_141734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "event_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "type", null: false
    t.integer "color", default: 0
    t.date "date", null: false
    t.string "title", null: false
    t.string "description"
    t.string "location_name", null: false
    t.string "location_lat", null: false
    t.string "location_long", null: false
    t.string "address", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "repeat_time", null: false
    t.integer "notification_time", null: false
    t.datetime "end_of_repeat", null: false
    t.boolean "is_private", default: true
    t.boolean "is_verified"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "parties_id"
    t.uuid "meetings_id"
    t.uuid "users_id", null: false
    t.integer "number_of_along"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetings_id"], name: "index_invites_on_meetings_id"
    t.index ["parties_id"], name: "index_invites_on_parties_id"
    t.index ["users_id"], name: "index_invites_on_users_id"
  end

  create_table "meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "events_id", null: false
    t.integer "priority", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["events_id"], name: "index_meetings_on_events_id"
  end

  create_table "national_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.date "date"
    t.boolean "is_day_off"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_national_events_on_user_id"
  end

  create_table "off_days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.date "date", null: false
    t.boolean "is_all_day"
    t.time "start"
    t.time "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_off_days_on_user_id"
  end

  create_table "our_laws", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.index ["user_id"], name: "index_our_laws_on_user_id"
  end

  create_table "parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "events_id", null: false
    t.string "theme", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["events_id"], name: "index_parties_on_events_id"
  end

  create_table "social_event_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_event_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.integer "price"
    t.boolean "is_available", default: true
    t.integer "capacity"
    t.boolean "is_accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_socials_on_user_id"
  end

  create_table "surprise_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "surprise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["surprise_id"], name: "index_surprise_users_on_surprise_id"
    t.index ["user_id"], name: "index_surprise_users_on_user_id"
  end

  create_table "surprises", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.string "fake_title"
    t.string "fake_description"
    t.string "theme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_surprises_on_event_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "family_name", null: false
    t.string "phone_number", null: false
    t.string "password_digest"
    t.string "email", null: false
    t.date "birthday", null: false
    t.integer "sex", null: false
    t.integer "role", default: 1
    t.string "photo"
    t.text "bio"
    t.string "username"
    t.string "location"
    t.boolean "is_private", default: true
    t.string "verification_code", null: false
    t.boolean "verified", default: false
    t.boolean "status", default: true
    t.datetime "verification_code_sent_at"
    t.boolean "forget_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_users_on_phone_number"
  end

  add_foreign_key "event_users", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_users", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invites", "meetings", column: "meetings_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invites", "parties", column: "parties_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invites", "users", column: "users_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "meetings", "events", column: "events_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "national_events", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "off_days", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "our_laws", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "parties", "events", column: "events_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "socials", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprise_users", "surprises", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprise_users", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprises", "events", on_update: :cascade, on_delete: :cascade
end
