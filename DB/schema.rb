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

ActiveRecord::Schema.define(version: 20171209025843) do

  create_table "diseases", force: :cascade do |t|
    t.string "title"
    t.string "part"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingrs", force: :cascade do |t|
    t.integer "medicine_id"
    t.string "name"
    t.integer "qnt"
    t.integer "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_ingrs_on_medicine_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "title"
    t.integer "code"
    t.date "ps_date"
    t.date "expir_date"
    t.integer "quantity"
    t.string "take_time"
    t.boolean "is_take"
    t.boolean "is_keep"
    t.boolean "is_alarm"
    t.integer "status"
    t.integer "user_id"
    t.integer "prescription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prescription_id"], name: "index_medicines_on_prescription_id"
    t.index ["user_id"], name: "index_medicines_on_user_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "title"
    t.string "hs_name"
    t.string "ds_name"
    t.date "ps_date"
    t.integer "cnt"
    t.string "st_time"
    t.boolean "is_alarm"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prescriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.boolean "pregnant"
    t.boolean "feeding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
