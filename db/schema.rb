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

ActiveRecord::Schema.define(version: 20140806035209) do

  create_table "articles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "draft"
    t.string   "image"
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

  create_table "game_boards", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
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

  create_table "notes", force: true do |t|
    t.string   "message"
    t.string   "action"
    t.boolean  "checked",       default: false
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "other_user_id"
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
  end

  create_table "prizes", force: true do |t|
    t.integer  "user_id"
    t.integer  "cash_prize"
    t.string   "winning_combo"
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
  end

end
