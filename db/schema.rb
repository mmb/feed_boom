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

ActiveRecord::Schema.define(version: 20130819160444) do

  create_table "feed_items", force: true do |t|
    t.text     "title"
    t.text     "link",       null: false
    t.text     "author"
    t.text     "content"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_items", ["feed_id"], name: "index_feed_items_on_feed_id"

  create_table "feeds", force: true do |t|
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "write_auth"
  end

  add_index "feeds", ["name"], name: "index_feeds_on_name", unique: true

end
