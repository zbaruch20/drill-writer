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

ActiveRecord::Schema[7.0].define(version: 2022_06_07_201203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drills", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "style", default: 0
    t.integer "ramp_cadences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_drills_on_user_id"
  end

  create_table "fundamentals", force: :cascade do |t|
    t.string "name"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moves", force: :cascade do |t|
    t.integer "num_eights"
    t.integer "position"
    t.bigint "drill_id", null: false
    t.bigint "fundamental_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drill_id"], name: "index_moves_on_drill_id"
    t.index ["fundamental_id"], name: "index_moves_on_fundamental_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "moves", "drills"
  add_foreign_key "moves", "fundamentals"
end
