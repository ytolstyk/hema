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

ActiveRecord::Schema.define(version: 20150905174723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name",       null: false
    t.date     "date"
    t.string   "organizer"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["location"], name: "index_events_on_location", using: :btree
  add_index "events", ["name"], name: "index_events_on_name", using: :btree
  add_index "events", ["organizer"], name: "index_events_on_organizer", using: :btree

  create_table "exchanges", force: true do |t|
    t.integer  "match_id",                   null: false
    t.string   "target"
    t.boolean  "afterblow",  default: false
    t.boolean  "double_hit", default: false
    t.integer  "penalty"
    t.integer  "fighter_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seconds",                    null: false
    t.integer  "points"
  end

  add_index "exchanges", ["fighter_id"], name: "index_exchanges_on_fighter_id", using: :btree
  add_index "exchanges", ["match_id"], name: "index_exchanges_on_match_id", using: :btree

  create_table "fighters", force: true do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "school"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fighters", ["gender"], name: "index_fighters_on_gender", using: :btree
  add_index "fighters", ["last_name"], name: "index_fighters_on_last_name", using: :btree
  add_index "fighters", ["school"], name: "index_fighters_on_school", using: :btree

  create_table "match_fighters", force: true do |t|
    t.integer  "fighter_id", null: false
    t.integer  "match_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_fighters", ["fighter_id", "match_id"], name: "index_match_fighters_on_fighter_id_and_match_id", unique: true, using: :btree
  add_index "match_fighters", ["fighter_id"], name: "index_match_fighters_on_fighter_id", using: :btree
  add_index "match_fighters", ["match_id"], name: "index_match_fighters_on_match_id", using: :btree

  create_table "match_infos", force: true do |t|
    t.integer  "match_id",                        null: false
    t.boolean  "match_completed", default: false
    t.boolean  "match_started",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_infos", ["match_id"], name: "index_match_infos_on_match_id", using: :btree

  create_table "matches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pool_id",    null: false
    t.integer  "index"
  end

  add_index "matches", ["pool_id"], name: "index_matches_on_pool_id", using: :btree

  create_table "pool_fighters", force: true do |t|
    t.integer  "pool_id",    null: false
    t.integer  "fighter_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pool_fighters", ["fighter_id"], name: "index_pool_fighters_on_fighter_id", using: :btree
  add_index "pool_fighters", ["pool_id", "fighter_id"], name: "index_pool_fighters_on_pool_id_and_fighter_id", unique: true, using: :btree
  add_index "pool_fighters", ["pool_id"], name: "index_pool_fighters_on_pool_id", using: :btree

  create_table "pools", force: true do |t|
    t.string   "name"
    t.integer  "tournament_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pools", ["tournament_id"], name: "index_pools_on_tournament_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "tournament_id", null: false
    t.string   "target",        null: false
    t.integer  "points",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["target", "tournament_id"], name: "index_scores_on_target_and_tournament_id", unique: true, using: :btree
  add_index "scores", ["tournament_id"], name: "index_scores_on_tournament_id", using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "name",           null: false
    t.string   "weapon_type",    null: false
    t.integer  "event_id",       null: false
    t.string   "gender"
    t.string   "material"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.integer  "victory_points"
  end

  add_index "tournaments", ["event_id"], name: "index_tournaments_on_event_id", using: :btree
  add_index "tournaments", ["gender"], name: "index_tournaments_on_gender", using: :btree
  add_index "tournaments", ["material"], name: "index_tournaments_on_material", using: :btree
  add_index "tournaments", ["name"], name: "index_tournaments_on_name", using: :btree
  add_index "tournaments", ["weapon_type"], name: "index_tournaments_on_weapon_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
