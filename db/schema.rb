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

ActiveRecord::Schema.define(version: 20141119222403) do

  create_table "activities", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "action"
    t.string   "ip"
    t.text     "info_text"
    t.string   "data_string"
    t.integer  "item_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.integer  "zip_code"
  end

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "draft"
    t.string   "image"
    t.boolean  "ad"
    t.integer  "zip_code"
    t.string   "hyperlink"
    t.integer  "views"
  end

  create_table "banners", force: true do |t|
    t.string   "image"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
    t.integer  "user_id"
    t.integer  "game_board_id"
    t.string   "image"
    t.string   "title"
    t.boolean  "redeemed"
    t.integer  "board_loc"
    t.integer  "zip_code"
  end

  create_table "codes", force: true do |t|
    t.integer  "code"
    t.string   "title"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_a_board"
    t.string   "advertiser"
    t.integer  "board_number"
    t.integer  "board_loc"
    t.date     "expiration"
    t.integer  "zip_code"
  end

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "text"
    t.integer  "comment_id"
    t.integer  "post_id"
  end

  create_table "events", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.date     "date"
    t.time     "time"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "location"
  end

  create_table "features", force: true do |t|
    t.integer  "user_id"
    t.integer  "tab_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_boards", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
    t.integer  "board_number"
    t.integer  "zip_code"
  end

  create_table "groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hashtags", force: true do |t|
    t.integer  "post_id"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
    t.integer  "comment_id"
    t.integer  "user_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.text     "text"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "message"
    t.string   "action"
    t.boolean  "checked",    default: false
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tab_id"
    t.integer  "subtab_id"
    t.integer  "zip_code"
    t.boolean  "translation_requested"
    t.text     "english_version"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.date     "expiration_date"
    t.integer  "repopulation_interval"
    t.integer  "reincarnations"
  end

  create_table "prizes", force: true do |t|
    t.integer  "user_id"
    t.integer  "cash_prize"
    t.string   "winning_combo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_number"
    t.integer  "game_board_id"
  end

  create_table "subtabs", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved"
    t.integer  "tab_id"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "english_name"
  end

  create_table "tabs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "icon"
    t.boolean  "approved"
    t.integer  "user_id"
    t.boolean  "sponsored"
    t.string   "company"
    t.boolean  "sponsored_only"
    t.integer  "zip_code"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "english_name"
  end

  create_table "tasks", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: true do |t|
    t.string   "english"
    t.string   "spanish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "password"
    t.boolean  "admin"
    t.boolean  "active"
    t.boolean  "writer"
    t.integer  "zip_code"
    t.string   "email"
    t.string   "icon"
    t.text     "bio"
    t.integer  "network_size"
    t.boolean  "business"
    t.boolean  "english"
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "auth_token"
    t.boolean  "master"
  end

  create_table "votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "up"
    t.boolean  "down"
    t.integer  "voter_id"
    t.integer  "post_id"
  end

  create_table "zips", force: true do |t|
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

end
