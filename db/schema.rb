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

ActiveRecord::Schema.define(version: 20141102020858) do

  create_table "apps", force: true do |t|
    t.integer  "user_id"
    t.float    "gpa"
    t.text     "current_position"
    t.text     "past_position"
    t.text     "sis_events"
    t.text     "achievement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote_count"
    t.string   "semester"
    t.boolean  "award"
    t.boolean  "open",                    default: true
    t.integer  "semester_active"
    t.integer  "semester_id"
    t.text     "semester_inactive"
    t.string   "major"
    t.string   "minor"
    t.integer  "credit_count"
    t.string   "academic_probation"
    t.text     "post_grad_goal"
    t.text     "position_accomplishment"
    t.text     "sis_event_planning"
    t.text     "org_improvement"
    t.text     "com_service_attended"
    t.text     "com_service_planning"
    t.text     "other_org_membership"
    t.text     "workshop_attended"
    t.text     "workshop_planning"
    t.text     "cv"
  end

  add_index "apps", ["user_id"], name: "index_apps_on_user_id"

  create_table "donations", force: true do |t|
    t.integer  "user_id"
    t.integer  "semester_id"
    t.decimal  "amt",         precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",                                default: false
  end

  add_index "donations", ["semester_id"], name: "index_donations_on_semester_id"
  add_index "donations", ["user_id"], name: "index_donations_on_user_id"

  create_table "semesters", force: true do |t|
    t.date     "year"
    t.integer  "season"
    t.date     "app_deadline"
    t.date     "vote_deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "nickname"
    t.string   "greek_class"
    t.string   "xseason"
    t.string   "gradyr"
    t.string   "status"
    t.string   "role"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_voted",              default: false
    t.boolean  "approved",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
