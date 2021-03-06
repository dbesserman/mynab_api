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

ActiveRecord::Schema.define(version: 2018_12_02_134537) do

  create_table "budget_events", force: :cascade do |t|
    t.string "event_type"
    t.integer "month_index"
    t.integer "year"
    t.integer "variation"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "account"
    t.string "payee"
    t.string "category"
    t.integer "variation"
    t.datetime "date_time"
    t.boolean "cleared"
    t.integer "category_id"
  end

end
