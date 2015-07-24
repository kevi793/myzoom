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

ActiveRecord::Schema.define(version: 20150724065441) do

  create_table "booking_status_time_stamps", force: :cascade do |t|
    t.integer  "booking_id",                limit: 4
    t.integer  "booking_status_from_state", limit: 4
    t.integer  "booking_status_to_state",   limit: 4
    t.integer  "user_id",                   limit: 4
    t.datetime "created_at"
  end

  add_index "booking_status_time_stamps", ["booking_id"], name: "index_booking_status_time_stamps_on_booking_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "car_id",         limit: 4
    t.integer  "car_group_id",   limit: 4
    t.integer  "location_id",    limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "booking_status", limit: 4
  end

  add_index "bookings", ["user_id", "car_group_id", "location_id"], name: "index_bookings_on_user_id_and_car_group_id_and_location_id", using: :btree

  create_table "car_groups", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "seats",             limit: 4
    t.integer  "tariff",            limit: 4
    t.integer  "minimum_billing",   limit: 4
    t.string   "image_url",         limit: 255
    t.integer  "excess_km_charges", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "carblocks", force: :cascade do |t|
    t.integer  "car_id",       limit: 4
    t.integer  "location_id",  limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "car_group_id", limit: 4
  end

  add_index "carblocks", ["car_id", "location_id"], name: "index_carblocks_on_car_id_and_location_id", using: :btree

  create_table "carmovements", force: :cascade do |t|
    t.integer  "car_id",       limit: 4
    t.integer  "location_id",  limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "car_group_id", limit: 4
  end

  add_index "carmovements", ["car_id", "location_id"], name: "index_carmovements_on_car_id_and_location_id", using: :btree

  create_table "cars", force: :cascade do |t|
    t.integer  "car_group_id", limit: 4
    t.integer  "location_id",  limit: 4
    t.string   "name",         limit: 255
    t.string   "car_status",   limit: 6,   default: "live"
    t.string   "color",        limit: 255
    t.string   "image_url",    limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "cars", ["car_group_id"], name: "index_cars_on_car_group_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string "name", limit: 25, null: false
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "car_group_id",   limit: 4
    t.integer  "location_id",    limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "number_of_cars", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "inventories", ["start_time", "end_time"], name: "index_inventories_on_start_time_and_end_time", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer "city_id",     limit: 4
    t.string  "name",        limit: 25
    t.string  "address",     limit: 100
    t.float   "latitude",    limit: 24
    t.float   "longitude",   limit: 24
    t.string  "map_link",    limit: 255
    t.string  "description", limit: 100
  end

  add_index "locations", ["city_id", "name"], name: "index_locations_on_city_id_and_name", using: :btree

  create_table "price_details", force: :cascade do |t|
    t.integer "price_id",            limit: 4
    t.integer "fare_per_hour",       limit: 4
    t.integer "fare_per_day",        limit: 4
    t.integer "fare_per_week",       limit: 4
    t.integer "extra_fare_per_day",  limit: 4
    t.integer "extra_fare_per_week", limit: 4
    t.integer "extra_fare_per_hour", limit: 4
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "car_group_id", limit: 4
    t.integer  "city_id",      limit: 4
    t.integer  "day_type",     limit: 4
    t.datetime "start_time"
    t.datetime "created_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "first_name",      limit: 25,  null: false
    t.string   "last_name",       limit: 25,  null: false
    t.string   "email",           limit: 100, null: false
    t.string   "password_digest", limit: 60
    t.string   "remember_token",  limit: 255
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
