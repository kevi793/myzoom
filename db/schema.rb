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

ActiveRecord::Schema.define(version: 20150716081719) do

  create_table "cities", force: :cascade do |t|
    t.string "name", limit: 25, null: false
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer "city_id",     limit: 4
    t.string  "name",        limit: 25,  null: false
    t.string  "address",     limit: 100, null: false
    t.float   "latitude",    limit: 24,  null: false
    t.float   "longitude",   limit: 24,  null: false
    t.string  "map_link",    limit: 255, null: false
    t.string  "description", limit: 100, null: false
  end

  add_index "locations", ["city_id", "name"], name: "index_locations_on_city_id_and_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "first_name",      limit: 25,  null: false
    t.string   "last_name",       limit: 25,  null: false
    t.string   "email",           limit: 100, null: false
    t.string   "password_digest", limit: 40
  end

end
