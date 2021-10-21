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

ActiveRecord::Schema.define(version: 2021_10_21_114606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bearers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower((name)::text)", name: "index_bearers_on_lowercase_name", unique: true
  end

  create_table "stocks", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "bearer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index "lower((name)::text)", name: "index_stocks_on_lowercase_name", unique: true
    t.index ["bearer_id"], name: "index_stocks_on_bearer_id"
    t.index ["discarded_at"], name: "index_stocks_on_discarded_at"
  end

  add_foreign_key "stocks", "bearers"
end
