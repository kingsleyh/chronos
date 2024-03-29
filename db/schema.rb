# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131004185451) do

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "customer_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "project_id"
    t.boolean  "active"
    t.decimal  "duration",    precision: 10, scale: 0
    t.boolean  "billable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timerows", force: true do |t|
    t.integer  "timesheet_id"
    t.string   "task_name"
    t.integer  "task_id"
    t.float    "monday",       default: 0.0
    t.float    "tuesday",      default: 0.0
    t.float    "wednesday",    default: 0.0
    t.float    "thursday",     default: 0.0
    t.float    "friday",       default: 0.0
    t.float    "saturday",     default: 0.0
    t.float    "sunday",       default: 0.0
    t.float    "total",        default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timesheets", force: true do |t|
    t.datetime "week_commencing"
    t.string   "status",          default: "new"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.text     "authorised_tasks"
    t.text     "default_task"
    t.boolean  "active",                 default: true
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
