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

ActiveRecord::Schema.define(version: 2020_09_08_160701) do

  create_table "bearers", force: :cascade do |t|
    t.string "name", null: false
    t.string "reference", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bearers_on_name", unique: true
    t.index ["reference"], name: "index_bearers_on_reference", unique: true
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "bearer_id", null: false
    t.string "name", null: false
    t.string "reference", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["bearer_id"], name: "index_stocks_on_bearer_id"
    t.index ["deleted_at"], name: "index_stocks_on_deleted_at"
    t.index ["name"], name: "index_stocks_on_name", unique: true
    t.index ["reference"], name: "index_stocks_on_reference", unique: true
  end

  add_foreign_key "stocks", "bearers"
end
