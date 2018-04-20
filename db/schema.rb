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

ActiveRecord::Schema.define(version: 20180419154403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clubs", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.integer "points", default: 0
    t.integer "position"
    t.integer "goals_diff", default: 0
    t.integer "win", default: 0
    t.integer "draw", default: 0
    t.integer "lose", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.bigint "tour_id", null: false
    t.bigint "host_id", null: false
    t.bigint "guest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "result"
  end

  create_table "members", force: :cascade do |t|
    t.decimal "total_score", precision: 3, scale: 1, default: "0.0", null: false
    t.decimal "points", precision: 3, scale: 1, default: "0.0", null: false
    t.integer "status", default: 0, null: false
    t.integer "scored_goals", default: 0, null: false
    t.integer "scored_penalties", default: 0, null: false
    t.integer "conceded_goals", default: 0, null: false
    t.integer "missed_penalties", default: 0, null: false
    t.integer "assists", default: 0, null: false
    t.integer "clean_sheets", default: 0, null: false
    t.integer "yellow_cards", default: 0, null: false
    t.integer "red_cards", default: 0, null: false
    t.integer "own_goals", default: 0, null: false
    t.bigint "player_id", null: false
    t.bigint "squad_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_members_on_player_id"
    t.index ["squad_id"], name: "index_members_on_squad_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "init_price"
    t.integer "actual_price"
    t.string "avatar"
    t.bigint "club_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_players_on_club_id"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "years", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "squads", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "tour_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_score", precision: 3, scale: 1, default: "0.0", null: false
    t.integer "goals", default: 0, null: false
    t.integer "points", default: 0, null: false
    t.index ["team_id"], name: "index_squads_on_team_id"
    t.index ["tour_id"], name: "index_squads_on_tour_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "tours", force: :cascade do |t|
    t.integer "number", null: false
    t.date "base_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.integer "status", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
