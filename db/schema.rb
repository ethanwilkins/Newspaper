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

ActiveRecord::Schema.define(version: 20150513023617) do

  create_table "activities", force: :cascade do |t|
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
    t.integer  "zip_code"
    t.string   "city"
    t.string   "address"
    t.string   "item_type"
    t.string   "browser_name"
    t.boolean  "mobile"
  end

  create_table "articles", force: :cascade do |t|
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
    t.boolean  "english"
    t.boolean  "translation_requested"
    t.integer  "tab_id"
    t.boolean  "requires_approval"
    t.integer  "subtab_id"
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image"
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
    t.string   "image"
    t.string   "name"
    t.boolean  "redeemed"
    t.integer  "board_loc"
    t.integer  "zip_code"
  end

  create_table "choices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "poll_id"
    t.text     "text"
  end

  create_table "codes", force: :cascade do |t|
    t.string   "code"
    t.string   "card_name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_a_board"
    t.string   "advertiser"
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
    t.integer  "poll_id"
  end

  create_table "events", force: :cascade do |t|
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
    t.boolean  "translation_requested"
    t.boolean  "english"
    t.integer  "zip_code"
    t.integer  "tab_id"
    t.integer  "subtab_id"
  end

  create_table "features", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tab_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "personal"
    t.integer  "subtab_id"
    t.boolean  "turned_on",  default: true
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
    t.boolean  "default"
  end

  create_table "hashtags", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "tag"
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

  create_table "loading_gifs", force: :cascade do |t|
    t.string   "image"
    t.integer  "tab_id"
    t.integer  "subtab_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "status"
    t.integer  "tab_id"
    t.integer  "subtab_id"
    t.boolean  "made_member"
    t.integer  "tournament_id"
    t.integer  "sports_team_id"
    t.integer  "sports_match_id"
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
    t.string   "message"
    t.string   "action"
    t.boolean  "checked",    default: false
    t.integer  "item_id"
    t.integer  "user_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.integer  "zip_code"
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "image"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tab_id"
    t.integer  "subtab_id"
    t.text     "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "posts", force: :cascade do |t|
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
    t.string   "ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
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
    t.string   "winning_combo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_number"
    t.integer  "game_board_id"
    t.integer  "group_id"
    t.integer  "code_id"
    t.string   "combo_type"
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "query"
    t.string   "chosen_result_type"
    t.integer  "chosen_result_id"
    t.integer  "user_id"
  end

  create_table "sports_matches", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "tab_id"
    t.integer  "tournament_id"
    t.boolean  "exhibition"
    t.string   "icon"
    t.text     "location"
    t.datetime "date"
    t.integer  "round",           default: 0
    t.integer  "sports_match_id"
  end

  create_table "sports_teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tab_id"
    t.text     "name"
    t.string   "icon"
  end

  create_table "stats", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "sports_team_id"
    t.integer  "sports_match_id"
    t.integer  "tournament_id"
    t.integer  "winning_team_id"
    t.integer  "losing_team_id"
    t.string   "kind"
    t.integer  "winning_score"
    t.integer  "losing_score"
    t.boolean  "finished"
    t.string   "image"
    t.integer  "first_teams_score"
    t.integer  "second_teams_score"
  end

  create_table "subtabs", force: :cascade do |t|
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
    t.integer  "zip_code"
    t.boolean  "sponsored_only"
    t.boolean  "sponsored"
    t.boolean  "translation_requested"
    t.string   "company"
    t.boolean  "english"
    t.boolean  "invite_only"
  end

  create_table "tabs", force: :cascade do |t|
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
    t.boolean  "translation_requested"
    t.boolean  "english"
    t.boolean  "invite_only"
    t.boolean  "hidden"
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "kind"
    t.text     "tip"
  end

  create_table "tournaments", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "tab_id"
    t.string   "icon"
    t.datetime "date"
    t.text     "location"
    t.boolean  "double_elimination"
    t.integer  "total_rounds"
    t.integer  "current_round",      default: 0
    t.boolean  "qualifying"
  end

  create_table "translations", force: :cascade do |t|
    t.string   "english"
    t.string   "spanish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "request"
    t.integer  "tab_id"
    t.integer  "post_id"
    t.integer  "event_id"
    t.integer  "article_id"
    t.string   "field"
    t.integer  "subtab_id"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "group_id"
    t.boolean  "dev"
    t.boolean  "test"
    t.boolean  "global"
    t.string   "privilege"
    t.string   "password_salt"
    t.boolean  "skipped_tour"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "up"
    t.boolean  "down"
    t.integer  "voter_id"
    t.integer  "post_id"
    t.integer  "choice_id"
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
