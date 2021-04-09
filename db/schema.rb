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

ActiveRecord::Schema.define(version: 2021_04_09_155519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "faculty_id", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_majors_on_faculty_id"
  end

  create_table "midterm_evaluations", force: :cascade do |t|
    t.bigint "thesis_member_id", null: false
    t.boolean "passed", null: false
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["thesis_member_id"], name: "index_midterm_evaluations_on_thesis_member_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "theses", force: :cascade do |t|
    t.bigint "thesis_proposal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ordering"
    t.string "title"
    t.string "english_title"
    t.bigint "primary_advisor_id", null: false
    t.index ["primary_advisor_id"], name: "index_theses_on_primary_advisor_id"
    t.index ["thesis_proposal_id"], name: "index_theses_on_thesis_proposal_id"
  end

  create_table "thesis_members", force: :cascade do |t|
    t.bigint "thesis_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.index ["student_id"], name: "index_thesis_members_on_student_id"
    t.index ["thesis_id"], name: "index_thesis_members_on_thesis_id"
  end

  create_table "thesis_proposals", force: :cascade do |t|
    t.bigint "topic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_thesis_proposals_on_topic_id"
  end

  create_table "topic_applications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_topic_applications_on_topic_id"
    t.index ["user_id"], name: "index_topic_applications_on_user_id", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.bigint "primary_advisor_id", null: false
    t.string "program", default: "CS", null: false
    t.integer "number_of_students", default: 1, null: false
    t.text "mission"
    t.string "references", default: [], array: true
    t.string "english_title"
    t.index ["primary_advisor_id"], name: "index_topics_on_primary_advisor_id"
    t.check_constraint "number_of_students >= 1", name: "check_number_of_students"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "department_id"
    t.string "name", null: false
    t.integer "mssv"
    t.string "type"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "mscb"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "departments", "faculties"
  add_foreign_key "majors", "faculties"
  add_foreign_key "midterm_evaluations", "thesis_members"
  add_foreign_key "theses", "users", column: "primary_advisor_id"
  add_foreign_key "thesis_members", "users", column: "student_id"
  add_foreign_key "topics", "users", column: "primary_advisor_id"
end
