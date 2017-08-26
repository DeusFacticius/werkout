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

ActiveRecord::Schema.define(version: 20170816204851) do

  create_table "cardios", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "duration",                       null: false
    t.integer  "resistance_level", default: 1,   null: false
    t.text     "notes"
    t.decimal  "distance",         default: 0.0, null: false
    t.decimal  "calories"
    t.integer  "workout_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "cardios", ["workout_id"], name: "index_cardios_on_workout_id"

  create_table "exercise_sets", force: :cascade do |t|
    t.decimal  "weight"
    t.decimal  "reps"
    t.decimal  "target_reps"
    t.text     "notes"
    t.integer  "exercise_id"
    t.integer  "sort_order",  default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "exercise_sets", ["exercise_id"], name: "index_exercise_sets_on_exercise_id"

  create_table "exercises", force: :cascade do |t|
    t.string   "name",                   null: false
    t.text     "notes"
    t.integer  "workout_id"
    t.integer  "sort_order", default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "exercises", ["workout_id"], name: "index_exercises_on_workout_id"

  create_table "workouts", force: :cascade do |t|
    t.date     "workout_date", null: false
    t.time     "time_started"
    t.time     "time_ended"
    t.string   "split_name"
    t.text     "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
