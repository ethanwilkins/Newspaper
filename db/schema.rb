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

ActiveRecord::Schema.define(version: 20150131194808) do

  create_table "activities", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "action",      limit: 255
    t.string   "ip",          limit: 255
    t.text     "info_text"
    t.string   "data_string", limit: 255
    t.integer  "item_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address",     limit: 255
    t.integer  "zip_code"
    t.string   "item_type",   limit: 255
  end

  create_table "articles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                 limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "draft"
    t.string   "image",                 limit: 255
    t.boolean  "ad"
    t.integer  "zip_code"
    t.string   "hyperlink",             limit: 255
    t.integer  "views"
    t.boolean  "english"
    t.boolean  "translation_requested"
    t.integer  "tab_id"
    t.boolean  "requires_approval"
    t.integer  "subtab_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
    t.integer  "user_id"
    t.integer  "game_board_id"
    t.string   "image",         limit: 255
    t.string   "name",          limit: 255
    t.boolean  "redeemed"
    t.integer  "board_loc"
    t.integer  "zip_code"
  end

  create_table "codes", force: :cascade do |t|
    t.string   "code",         limit: 255
    t.string   "card_name",    limit: 255
    t.string   "image",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_a_board"
    t.string   "advertiser",   limit: 255
    t.integer  "board_number"
    t.integer  "board_loc"
    t.date     "expiration"
    t.integer  "zip_code"
    t.integer  "group_id"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "article_id"
    t.text     "body"
    t.integer  "comment_id"
    t.integer  "post_id"
    t.integer  "translation_id"
    t.integer  "event_id"
    t.integer  "activity_id"
    t.integer  "banner_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                 limit: 255
    t.text     "body"
    t.date     "date"
    t.time     "time"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",                 limit: 255
    t.string   "location",              limit: 255
    t.boolean  "translation_requested"
    t.boolean  "english"
    t.integer  "zip_code"
    t.integer  "tab_id"
    t.integer  "subtab_id"
  end

  create_table "features", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tab_id"
    t.string   "action",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "personal"
    t.integer  "subtab_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "article_id"
    t.integer  "comment_id"
    t.integer  "event_id"
    t.integer  "tab_id"
    t.integer  "stars"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviewer_id"
  end

  create_table "folders", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  create_table "game_boards", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
    t.integer  "board_number"
    t.integer  "zip_code"
    t.integer  "group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_prizes"
  end

  create_table "hashtags", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "tag",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "index"
    t.integer  "tab_id"
    t.integer  "subtab_id"
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "status",     limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.text     "text"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.string   "action",     limit: 255
    t.boolean  "checked",                default: false
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",        limit: 255
    t.integer  "zip_code"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                 limit: 255
    t.text     "body"
    t.string   "image",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tab_id"
    t.integer  "subtab_id"
    t.integer  "zip_code"
    t.boolean  "translation_requested"
    t.string   "ip",                    limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address",               limit: 255
    t.date     "expiration_date"
    t.integer  "repopulation_interval"
    t.integer  "reincarnations"
    t.boolean  "english"
    t.boolean  "sale"
    t.boolean  "photoset"
  end

  create_table "prizes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cash_prize"
    t.string   "winning_combo", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_number"
    t.integer  "game_board_id"
    t.integer  "group_id"
    t.integer  "code_id"
    t.string   "combo_type",    limit: 255
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query",              limit: 255
    t.string   "chosen_result_type", limit: 255
    t.integer  "chosen_result_id"
    t.integer  "user_id"
  end

  create_table "subtabs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                  limit: 255
    t.string   "description",           limit: 255
    t.string   "icon",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved"
    t.integer  "tab_id"
    t.string   "ip",                    limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address",               limit: 255
    t.integer  "zip_code"
    t.boolean  "sponsored_only"
    t.boolean  "sponsored"
    t.boolean  "translation_requested"
    t.string   "company"
    t.boolean  "english"
  end

  create_table "tabs", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",           limit: 255
    t.string   "icon",                  limit: 255
    t.boolean  "approved"
    t.integer  "user_id"
    t.boolean  "sponsored"
    t.string   "company",               limit: 255
    t.boolean  "sponsored_only"
    t.integer  "zip_code"
    t.string   "ip",                    limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address",               limit: 255
    t.boolean  "translation_requested"
    t.boolean  "english"
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: :cascade do |t|
    t.string   "english",    limit: 255
    t.string   "spanish",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "request"
    t.integer  "tab_id"
    t.integer  "post_id"
    t.integer  "event_id"
    t.integer  "article_id"
    t.string   "field",      limit: 255
    t.integer  "subtab_id"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",         limit: 255
    t.string   "password",     limit: 255
    t.boolean  "admin"
    t.boolean  "active"
    t.boolean  "writer"
    t.integer  "zip_code"
    t.string   "email",        limit: 255
    t.string   "icon",         limit: 255
    t.text     "bio"
    t.integer  "network_size"
    t.boolean  "business"
    t.boolean  "english"
    t.string   "ip",           limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address",      limit: 255
    t.string   "auth_token",   limit: 255
    t.boolean  "master"
    t.integer  "group_id"
    t.boolean  "dev"
    t.boolean  "test"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "up"
    t.boolean  "down"
    t.integer  "voter_id"
    t.integer  "post_id"
  end

  create_table "zips", force: :cascade do |t|
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "group_id"
  end

end
