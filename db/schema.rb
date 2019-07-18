# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_18_103313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "auth_records", force: :cascade do |t|
    t.string "api_client"
    t.string "api_key"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_auth_records_on_user_id"
  end

  create_table "computers", force: :cascade do |t|
    t.string "connecter_guid"
    t.string "hostname"
    t.boolean "active"
    t.string "connector_version"
    t.string "operating_system"
    t.string "internal_ips", default: [], array: true
    t.string "external_ip"
    t.string "group_guid"
    t.datetime "install_date"
    t.datetime "last_seen"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_computers_on_slug", unique: true
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

  create_table "user_activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "computer_id", null: false
    t.string "severity"
    t.string "event_type"
    t.string "detection"
    t.datetime "detected_date"
    t.string "user_name"
    t.jsonb "file", default: "{}"
    t.index ["computer_id"], name: "index_user_activities_on_computer_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vulnarabilities", force: :cascade do |t|
    t.string "application"
    t.string "version"
    t.jsonb "file", default: "{}"
    t.jsonb "cves", default: "{}"
    t.datetime "latest_date"
    t.bigint "computer_id"
    t.index ["computer_id"], name: "index_vulnarabilities_on_computer_id"
  end

  add_foreign_key "user_activities", "computers"
  add_foreign_key "user_activities", "users"
end
