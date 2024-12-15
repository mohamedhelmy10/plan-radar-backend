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

ActiveRecord::Schema.define(version: 2024_12_14_163237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ticket_id", null: false
    t.text "message"
    t.datetime "sent_at"
    t.integer "notification_type", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_notifications_on_ticket_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.integer "name", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "assigned_user_id"
    t.date "due_date"
    t.bigint "status_id"
    t.integer "progress", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reminder_job_id"
    t.index ["status_id"], name: "index_tickets_on_status_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "send_due_date_reminder", default: false
    t.integer "due_date_reminder_interval", default: 0
    t.time "due_date_reminder_time", default: "2000-01-01 08:00:00"
    t.string "time_zone", default: "Europe/Vienna"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "notifications", "tickets"
  add_foreign_key "notifications", "users"
  add_foreign_key "tickets", "statuses"
  add_foreign_key "tickets", "users", column: "assigned_user_id"
end
