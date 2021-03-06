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

ActiveRecord::Schema.define(version: 20150519120322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "id_game"
    t.integer  "id_user"
    t.integer  "s1"
    t.integer  "s2"
    t.integer  "points"
    t.boolean  "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "game_id"
  end

  add_index "bets", ["game_id"], name: "index_bets_on_game_id", using: :btree
  add_index "bets", ["user_id"], name: "index_bets_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["game_id"], name: "index_comments_on_game_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "identifiant"
    t.text     "description"
    t.string   "pool"
    t.string   "e1"
    t.string   "e2"
    t.integer  "s1"
    t.integer  "s2"
    t.date     "start"
    t.date     "end"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "pass"
  end

  create_table "leagues_users", id: false, force: :cascade do |t|
    t.integer "league_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "leagues_users", ["league_id"], name: "index_leagues_users_on_league_id", using: :btree
  add_index "leagues_users", ["user_id"], name: "index_leagues_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "bets", "games"
  add_foreign_key "bets", "users"
  add_foreign_key "comments", "games"
  add_foreign_key "comments", "users"
end
