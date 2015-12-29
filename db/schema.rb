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

ActiveRecord::Schema.define(version: 20151213180836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lines", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "line_id"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.text     "schedule"
    t.integer  "day"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "routes", ["destination_id"], name: "index_routes_on_destination_id", using: :btree
  add_index "routes", ["line_id"], name: "index_routes_on_line_id", using: :btree
  add_index "routes", ["origin_id"], name: "index_routes_on_origin_id", using: :btree

  create_table "stops", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "routes", "lines"
end
