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

ActiveRecord::Schema.define(version: 20150627220406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignment_submissions", force: :cascade do |t|
    t.integer "student_id",        null: false
    t.integer "assignment_id",     null: false
    t.string  "ref_id",            null: false
    t.string  "student_ref_id"
    t.string  "assignment_ref_id"
    t.decimal "score"
    t.string  "status"
  end

  create_table "assignments", force: :cascade do |t|
    t.jsonb    "students"
    t.string   "section_ref_id",  null: false
    t.integer  "section_id"
    t.string   "status"
    t.string   "description"
    t.string   "name"
    t.string   "ref_id"
    t.string   "creator_ref_id"
    t.integer  "staff_person_id"
    t.datetime "available_date"
    t.datetime "due_date"
  end

  create_table "parents", force: :cascade do |t|
    t.string "user_name",     null: false
    t.string "given_name",    null: false
    t.string "family_name",   null: false
    t.string "phone_number"
    t.string "email_address"
  end

  create_table "sections", force: :cascade do |t|
    t.string "status",      null: false
    t.string "school_year", null: false
    t.string "ref_id",      null: false
    t.string "name",        null: false
  end

  create_table "staff_people", force: :cascade do |t|
    t.string "user_name"
    t.string "ref_id"
    t.string "id_value"
    t.string "given_name"
    t.string "family_name"
    t.string "phone_number"
    t.string "email_address"
  end

  create_table "staff_section_associations", force: :cascade do |t|
    t.integer  "staff_person_id"
    t.integer  "section_id"
    t.string   "ref_id",          null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "student_section_associations", force: :cascade do |t|
    t.integer "student_id",     null: false
    t.integer "section_id",     null: false
    t.string  "ref_id",         null: false
    t.string  "student_ref_id"
    t.string  "section_ref_id"
    t.string  "school_year"
    t.string  "exit_date"
  end

  create_table "students", force: :cascade do |t|
    t.string  "user_name",     null: false
    t.string  "ref_id",        null: false
    t.string  "id_value",      null: false
    t.string  "given_name",    null: false
    t.string  "family_name",   null: false
    t.string  "phone_number"
    t.string  "email_address"
    t.integer "parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
