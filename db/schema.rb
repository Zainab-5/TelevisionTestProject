# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_12_132214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_apps_on_name", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "app_id", null: false
    t.string "available_for_type", null: false
    t.bigint "available_for_id", null: false
    t.string "country_code"
    t.string "stream_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_availabilities_on_app_id"
    t.index ["available_for_type", "available_for_id"], name: "index_availabilities_on_available_for"
    t.index ["country_code"], name: "index_availabilities_on_country_code"
  end

  create_table "channel_programs", force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_programs_on_channel_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.string "title"
    t.integer "number"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id", "number"], name: "index_episodes_on_season_id_and_number", unique: true
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "favorite_apps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "app_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_favorite_apps_on_app_id"
    t.index ["user_id", "app_id"], name: "index_favorite_apps_on_user_id_and_app_id", unique: true
    t.index ["user_id"], name: "index_favorite_apps_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "channel_program_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_schedules_on_channel_program_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "tv_show_id", null: false
    t.string "title"
    t.integer "number"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "time_watcheds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_program_id", null: false
    t.integer "seconds_watched"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_program_id"], name: "index_time_watcheds_on_channel_program_id"
    t.index ["user_id"], name: "index_time_watcheds_on_user_id"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.integer "duration_in_seconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "availabilities", "apps"
  add_foreign_key "channel_programs", "channels"
  add_foreign_key "episodes", "seasons"
  add_foreign_key "favorite_apps", "apps"
  add_foreign_key "favorite_apps", "users"
  add_foreign_key "schedules", "channel_programs"
  add_foreign_key "seasons", "tv_shows"
  add_foreign_key "time_watcheds", "channel_programs"
  add_foreign_key "time_watcheds", "users"
end
