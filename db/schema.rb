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

ActiveRecord::Schema[7.2].define(version: 2025_01_24_155420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_shows", force: :cascade do |t|
    t.string "company"
    t.string "url"
    t.string "script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_users", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_users_on_job_id"
    t.index ["user_id", "job_id"], name: "index_job_users_on_user_id_and_job_id", unique: true
    t.index ["user_id"], name: "index_job_users_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company_name"
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "employer"
    t.string "location"
    t.text "html_content"
  end

  create_table "jobs_users", id: false, force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "user_id", null: false
    t.index ["job_id"], name: "index_jobs_users_on_job_id"
    t.index ["user_id"], name: "index_jobs_users_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "job_users", "jobs"
  add_foreign_key "job_users", "users"
  add_foreign_key "sessions", "users"
end
