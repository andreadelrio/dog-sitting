# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151019033820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ages", force: true do |t|
    t.string  "age_group_name"
    t.integer "provider_id"
  end

  create_table "agings", force: true do |t|
    t.integer "provider_id"
    t.integer "age_id"
  end

  create_table "bookings", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "provider_id"
    t.string   "user_first_name"
    t.string   "user_last_name"
    t.string   "user_phone"
    t.string   "user_email"
    t.string   "user_message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ref_code"
    t.string   "raza"
    t.string   "edad"
    t.text     "cuidado_especial"
    t.string   "token"
    t.string   "address"
    t.datetime "pickup_time"
    t.datetime "dropoff_time"
    t.string   "pet_name"
  end

  add_index "bookings", ["provider_id"], name: "index_bookings_on_provider_id", using: :btree

  create_table "categories", force: true do |t|
    t.string "name"
  end

  create_table "localizations", force: true do |t|
    t.integer "provider_id"
    t.integer "location_id"
  end

  add_index "localizations", ["location_id"], name: "index_localizations_on_location_id", using: :btree
  add_index "localizations", ["provider_id"], name: "index_localizations_on_provider_id", using: :btree

  create_table "locations", force: true do |t|
    t.string  "name"
    t.integer "state_id"
    t.string  "utf_name"
  end

  create_table "meetings", force: true do |t|
    t.integer "provider_id"
    t.string  "user_first_name"
    t.string  "user_last_name"
    t.string  "user_phone"
    t.string  "user_email"
    t.string  "token"
  end

  add_index "meetings", ["provider_id"], name: "index_meetings_on_provider_id", using: :btree

  create_table "properties", force: true do |t|
    t.string "property_name"
  end

  create_table "provider_attachments", force: true do |t|
    t.integer  "provider_id"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "name"
    t.string   "last_name_1"
    t.string   "last_name_2"
    t.string   "dni"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.float    "avg_rating"
    t.string   "phone"
    t.text     "description"
    t.string   "email_c"
    t.string   "avatar"
    t.float    "price"
    t.string   "areas_externas"
    t.boolean  "emergencia"
    t.integer  "experiencia"
    t.text     "iframe_code"
    t.integer  "property_id"
  end

  create_table "referrals", force: true do |t|
    t.string   "code_value"
    t.string   "referrer_name"
    t.string   "referrer_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.string  "size_title"
    t.integer "provider_id"
  end

  create_table "sizings", force: true do |t|
    t.integer "provider_id"
    t.integer "size_id"
  end

  create_table "states", force: true do |t|
    t.string "name"
  end

end
