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

ActiveRecord::Schema.define(version: 20150703184155) do

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

  create_table "tournament_fighters", force: true do |t|
    t.integer  "fighter_id"
    t.integer  "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournament_fighters", ["fighter_id"], name: "index_tournament_fighters_on_fighter_id", using: :btree
  add_index "tournament_fighters", ["tournament_id"], name: "index_tournament_fighters_on_tournament_id", using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "name",       null: false
    t.string   "type",       null: false
    t.integer  "event_id",   null: false
    t.string   "gender"
    t.string   "material"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["event_id"], name: "index_tournaments_on_event_id", using: :btree
  add_index "tournaments", ["gender"], name: "index_tournaments_on_gender", using: :btree
  add_index "tournaments", ["material"], name: "index_tournaments_on_material", using: :btree
  add_index "tournaments", ["name"], name: "index_tournaments_on_name", using: :btree
  add_index "tournaments", ["type"], name: "index_tournaments_on_type", using: :btree

end
