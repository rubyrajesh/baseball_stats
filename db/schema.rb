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

ActiveRecord::Schema.define(version: 20140415193434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "player_season_averages", force: true do |t|
    t.integer  "player_id"
    t.integer  "year"
    t.string   "league"
    t.float    "average"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "player_id",  null: false
    t.integer  "birth_year"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["player_id"], name: "index_players_on_player_id", using: :btree

  create_table "seasons", force: true do |t|
    t.integer  "player_id",                  null: false
    t.integer  "year",                       null: false
    t.string   "league",                     null: false
    t.string   "team",                       null: false
    t.integer  "at_bats",        default: 0, null: false
    t.integer  "hits",           default: 0, null: false
    t.integer  "doubles",        default: 0, null: false
    t.integer  "triples",        default: 0, null: false
    t.integer  "home_runs",      default: 0, null: false
    t.integer  "runs_batted_in", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["player_id", "league"], name: "index_seasons_on_player_id_and_league", using: :btree
  add_index "seasons", ["player_id", "team"], name: "index_seasons_on_player_id_and_team", using: :btree
  add_index "seasons", ["player_id", "year"], name: "index_seasons_on_player_id_and_year", using: :btree

end
