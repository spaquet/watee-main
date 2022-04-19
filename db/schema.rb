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

ActiveRecord::Schema[7.0].define(version: 2022_04_17_230904) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.bigint "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["owner"], name: "index_organizations_on_owner"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "nickname"
    t.bigint "organization_id"
    t.string "password_digest"
    t.boolean "blocked", default: false, null: false
    t.boolean "confirmed", default: false, null: false
    t.string "confirmation_token", null: false
    t.datetime "confirmation_token_expiration", precision: nil, null: false
    t.datetime "confirmed_at", precision: nil
    t.string "password_reset_token"
    t.datetime "password_reset_token_expiration", precision: nil
    t.datetime "password_reset_at", precision: nil
    t.boolean "locked", default: false, null: false
    t.datetime "locked_at", precision: nil
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked"], name: "index_users_on_blocked"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["confirmed"], name: "index_users_on_confirmed"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["locked"], name: "index_users_on_locked"
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
  end

  add_foreign_key "users", "organizations"
end
