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

ActiveRecord::Schema.define(version: 2019_01_06_163810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dashboards", force: :cascade do |t|
    t.string "keyword"
    t.float "average_salary", default: 0.0
    t.integer "searched_times", default: 0
    t.text "most_opportunities", default: [], array: true
    t.text "highest_paying", default: [], array: true
    t.text "high_freq_en"
    t.text "high_freq_zh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_qty"
    t.string "slug"
    t.index ["slug"], name: "index_dashboards_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "job_summaries", force: :cascade do |t|
    t.integer "qty"
    t.float "average_salary"
    t.text "location_qty", default: [], array: true
    t.text "location_salary", default: [], array: true
    t.bigint "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "url", default: [], array: true
    t.string "keyword"
    t.index ["search_id"], name: "index_job_summaries_on_search_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.float "salary"
    t.string "location"
    t.string "url"
    t.string "company"
    t.bigint "search_id"
    t.bigint "dashboard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keyword", default: ""
    t.index ["dashboard_id"], name: "index_jobs_on_dashboard_id"
    t.index ["search_id"], name: "index_jobs_on_search_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "average_salary"
    t.text "skills"
    t.string "slug"
    t.index ["slug"], name: "index_searches_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "job_summaries", "searches"
  add_foreign_key "jobs", "dashboards"
  add_foreign_key "jobs", "searches"
end
