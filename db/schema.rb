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

ActiveRecord::Schema.define(version: 2018_08_26_111807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "event_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_groups_on_event_id"
    t.index ["group_id"], name: "index_event_groups_on_group_id"
  end

  create_table "event_share_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "share_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_share_events_on_event_id"
    t.index ["share_event_id"], name: "index_event_share_events_on_share_event_id"
  end

  create_table "event_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_types_on_event_id"
    t.index ["type_id"], name: "index_event_types_on_type_id"
  end

  create_table "event_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "is_private", default: true
    t.string "title", null: false
    t.string "description"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "notification_time"
    t.integer "when_to_repeat"
    t.boolean "is_verified"
    t.boolean "is_with", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_types_on_group_id"
    t.index ["type_id"], name: "index_group_types_on_type_id"
  end

  create_table "group_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "group_id", null: false
    t.integer "status", default: 0
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.boolean "is_muted", default: false
    t.string "image"
    t.boolean "is_private", default: false
    t.boolean "is_verified", default: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invite_friends", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "events_id", null: false
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["events_id"], name: "index_invite_friends_on_events_id"
  end

  create_table "invitees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "invite_friends_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_friends_id"], name: "index_invitees_on_invite_friends_id"
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
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_off_days_on_user_id"
  end

  create_table "share_event_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "type_id", null: false
    t.uuid "share_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["share_event_id"], name: "index_share_event_types_on_share_event_id"
    t.index ["type_id"], name: "index_share_event_types_on_type_id"
  end

  create_table "share_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_surprises_on_event_id"
  end

  create_table "types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "color"
    t.boolean "is_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "type_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_user_types_on_type_id"
    t.index ["user_id"], name: "index_user_types_on_user_id"
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

  add_foreign_key "event_groups", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_groups", "groups", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_share_events", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_share_events", "share_events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_types", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_types", "types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_users", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "event_users", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "group_types", "groups", on_update: :cascade, on_delete: :cascade
  add_foreign_key "group_types", "types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "group_users", "groups", on_update: :cascade, on_delete: :cascade
  add_foreign_key "group_users", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invite_friends", "events", column: "events_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invitees", "invite_friends", column: "invite_friends_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "national_events", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "off_days", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "share_event_types", "share_events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "share_event_types", "types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "socials", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprise_users", "surprises", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprise_users", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "surprises", "events", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_types", "types", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_types", "users", on_update: :cascade, on_delete: :cascade
end
