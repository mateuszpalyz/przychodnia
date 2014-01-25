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

ActiveRecord::Schema.define(version: 20140125195121) do

  create_table "patients", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "pesel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  add_index "patients", ["pesel"], name: "index_patients_on_pesel", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "specialty"
    t.integer  "age"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "visits", force: true do |t|
    t.string   "cause"
    t.string   "psymptom"
    t.string   "time_symptom"
    t.string   "illness_chage"
    t.string   "symptom_type"
    t.string   "time_illness"
    t.string   "freq_illness"
    t.string   "care"
    t.string   "dsymptom"
    t.string   "illness"
    t.string   "drugs"
    t.integer  "user_id"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_been_changed"
    t.datetime "next_visit"
  end

  add_index "visits", ["patient_id"], name: "index_visits_on_patient_id"

end
