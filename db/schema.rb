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

ActiveRecord::Schema.define(version: 2019_04_27_221122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "short_code", null: false
    t.integer "credit_hours", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "user_id", null: false
    t.string "grade"
    t.index ["section_id"], name: "index_enrollment_on_section_id"
    t.index ["user_id"], name: "index_enrollment_on_user_id"
  end

  create_table "prerequisites", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "requirement_id", null: false
    t.string "minimum_grade", null: false
    t.index ["course_id"], name: "index_prerequisites_on_course_id"
    t.index ["requirement_id"], name: "index_prerequisites_on_requirement_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "number"
    t.integer "capacity"
  end

  create_table "section_assistants", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "user_id", null: false
    t.index ["section_id"], name: "index_section_assistants_on_section_id"
    t.index ["user_id"], name: "index_section_assistants_on_user_id"
    t.index ["section_id", "user_id"], name: "index_section_assistants_on_section_id_and_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "term_id", null: false
    t.bigint "room_id", null: false
    t.bigint "instructor_id", null: false
    t.index ["course_id"], name: "index_courses_on_course_id"
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
    t.index ["room_id"], name: "index_courses_on_room_id"
    t.index ["term_id"], name: "index_courses_on_term_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "quarter"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name", null: false
    t.boolean "on_probation", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "enrollments", "sections"
  add_foreign_key "enrollments", "users"
  add_foreign_key "prerequisites", "courses"
  add_foreign_key "prerequisites", "courses", column: "requirement_id"
  add_foreign_key "section_assistants", "sections"
  add_foreign_key "section_assistants", "users"
  add_foreign_key "sections", "courses"
  add_foreign_key "sections", "rooms"
  add_foreign_key "sections", "terms"
  add_foreign_key "sections", "users", column: "instructor_id"
end
