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

ActiveRecord::Schema.define(version: 2018_09_20_142240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "message_ins", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_outs", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nested_items", force: :cascade do |t|
    t.integer "task_id"
    t.integer "dataset_id"
    t.integer "datafile_id"
    t.string "item_path"
    t.string "item_name"
    t.bigint "size"
    t.boolean "is_directory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sent", default: false
  end

  create_table "peeks", force: :cascade do |t|
    t.integer "task_id"
    t.integer "datafile_id"
    t.string "peek_type"
    t.text "peek_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sent", default: false
  end

  create_table "problems", force: :cascade do |t|
    t.text "report"
    t.text "notes"
    t.boolean "resolved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "operation"
    t.integer "dataset_id"
    t.integer "datafile_id"
    t.string "storage_root"
    t.string "storage_key"
    t.string "binary_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "stop_time"
    t.boolean "handled", default: false
  end

end
