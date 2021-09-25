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

ActiveRecord::Schema.define(version: 2021_09_25_040015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "defense_committees", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.bigint "semester_id"
    t.integer "session", default: 0
    t.index ["department_id"], name: "index_defense_committees_on_department_id"
    t.index ["semester_id"], name: "index_defense_committees_on_semester_id"
  end

  create_table "defense_committees_members", force: :cascade do |t|
    t.bigint "defense_committee_id"
    t.bigint "lecturer_id"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["defense_committee_id"], name: "index_defense_committees_members_on_defense_committee_id"
    t.index ["lecturer_id"], name: "index_defense_committees_members_on_lecturer_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "faculty_id", null: false
    t.string "short_name", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "major_committee_members", force: :cascade do |t|
    t.bigint "lecturer_id"
    t.bigint "major_committee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_major_committee_members_on_lecturer_id"
    t.index ["major_committee_id"], name: "index_major_committee_members_on_major_committee_id"
  end

  create_table "major_committees", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "major_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["major_id"], name: "index_major_committees_on_major_id"
  end

  create_table "major_compositions", force: :cascade do |t|
    t.bigint "single_major_id"
    t.bigint "multi_major_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["multi_major_id"], name: "index_major_compositions_on_multi_major_id"
    t.index ["single_major_id"], name: "index_major_compositions_on_single_major_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type", default: "SingleMajor", null: false
    t.index ["faculty_id"], name: "index_majors_on_faculty_id"
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

  create_table "semesters", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "academic_year", null: false
    t.date "start_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "theses", force: :cascade do |t|
    t.bigint "thesis_proposal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ordering"
    t.string "title"
    t.string "english_title"
    t.text "mission"
    t.text "description"
    t.string "references", default: [], array: true
    t.integer "max_student_count", default: 1, null: false
    t.integer "status", default: 0
    t.string "education_program"
    t.string "majors", default: [], array: true
    t.bigint "semester_id", null: false
    t.date "assignment_date"
    t.date "completion_date"
    t.bigint "defense_committee_id"
    t.index ["defense_committee_id"], name: "index_theses_on_defense_committee_id"
    t.index ["semester_id"], name: "index_theses_on_semester_id"
    t.index ["thesis_proposal_id"], name: "index_theses_on_thesis_proposal_id"
    t.check_constraint "max_student_count >= 1", name: "check_thesis_max_student_count"
  end

  create_table "theses_advisor_evaluations", force: :cascade do |t|
    t.bigint "theses_member_id"
    t.integer "marking1"
    t.integer "marking2"
    t.integer "marking3"
    t.integer "marking4"
    t.integer "marking5"
    t.integer "marking6"
    t.integer "marking7"
    t.integer "marking8"
    t.integer "marking9"
    t.integer "bonus_point"
    t.string "bonus_reason"
    t.string "learning_outcome1"
    t.string "learning_outcome1_remark"
    t.string "learning_outcome2"
    t.string "learning_outcome2_remark"
    t.string "learning_outcome3"
    t.string "learning_outcome3_remark"
    t.string "learning_outcome4"
    t.string "learning_outcome4_remark"
    t.string "learning_outcome5"
    t.string "learning_outcome5_remark"
    t.string "learning_outcome6"
    t.string "learning_outcome6_remark"
    t.string "learning_outcome7"
    t.string "learning_outcome7_remark"
    t.string "learning_outcome8"
    t.string "learning_outcome8_remark"
    t.string "learning_outcome9"
    t.string "learning_outcome9_remark"
    t.string "learning_outcome10"
    t.string "learning_outcome10_remark"
    t.string "learning_outcome11"
    t.string "learning_outcome11_remark"
    t.string "learning_outcome12"
    t.string "learning_outcome12_remark"
    t.string "learning_outcome13"
    t.string "learning_outcome13_remark"
    t.string "learning_outcome14"
    t.string "learning_outcome14_remark"
    t.string "learning_outcome15"
    t.string "learning_outcome15_remark"
    t.string "opinion_about_form"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theses_member_id"], name: "index_theses_advisor_evaluations_on_theses_member_id"
  end

  create_table "theses_advisors", force: :cascade do |t|
    t.bigint "lecturer_id"
    t.bigint "thesis_id"
    t.boolean "primary", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_theses_advisors_on_lecturer_id"
    t.index ["thesis_id"], name: "index_theses_advisors_on_thesis_id"
  end

  create_table "theses_members", force: :cascade do |t|
    t.bigint "thesis_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.index ["student_id"], name: "index_theses_members_on_student_id"
    t.index ["thesis_id"], name: "index_theses_members_on_thesis_id"
  end

  create_table "theses_midterm_evaluations", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.boolean "passed", null: false
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_theses_midterm_evaluations_on_member_id"
  end

  create_table "theses_reviewer_evaluations", force: :cascade do |t|
    t.bigint "theses_member_id"
    t.integer "marking1"
    t.integer "marking2"
    t.integer "marking3"
    t.integer "marking4"
    t.integer "marking5"
    t.integer "marking6"
    t.integer "marking7"
    t.integer "marking8"
    t.integer "marking9"
    t.integer "bonus_point"
    t.string "bonus_reason"
    t.string "learning_outcome1"
    t.string "learning_outcome1_remark"
    t.string "learning_outcome2"
    t.string "learning_outcome2_remark"
    t.string "learning_outcome3"
    t.string "learning_outcome3_remark"
    t.string "learning_outcome4"
    t.string "learning_outcome4_remark"
    t.string "learning_outcome5"
    t.string "learning_outcome5_remark"
    t.string "learning_outcome6"
    t.string "learning_outcome6_remark"
    t.string "learning_outcome7"
    t.string "learning_outcome7_remark"
    t.string "learning_outcome8"
    t.string "learning_outcome8_remark"
    t.string "learning_outcome9"
    t.string "learning_outcome9_remark"
    t.string "opinion_about_form"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["theses_member_id"], name: "index_theses_reviewer_evaluations_on_theses_member_id"
  end

  create_table "theses_reviews", force: :cascade do |t|
    t.bigint "thesis_id"
    t.bigint "lecturer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_theses_reviews_on_lecturer_id"
    t.index ["thesis_id"], name: "index_theses_reviews_on_thesis_id"
  end

  create_table "thesis_proposal_advisors", force: :cascade do |t|
    t.bigint "thesis_proposal_id", null: false
    t.bigint "lecturer_id", null: false
    t.boolean "primary", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecturer_id"], name: "index_thesis_proposal_advisors_on_lecturer_id"
    t.index ["thesis_proposal_id"], name: "index_thesis_proposal_advisors_on_thesis_proposal_id"
  end

  create_table "thesis_proposal_members", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "thesis_proposal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_thesis_proposal_members_on_student_id"
    t.index ["thesis_proposal_id"], name: "index_thesis_proposal_members_on_thesis_proposal_id"
  end

  create_table "thesis_proposals", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ordering"
    t.string "title", null: false
    t.string "english_title"
    t.text "mission"
    t.text "description"
    t.string "references", default: [], array: true
    t.integer "max_student_count", default: 1, null: false
    t.integer "status", default: 0
    t.string "education_program"
    t.bigint "semester_id", null: false
    t.bigint "major_id", null: false
    t.index ["major_id"], name: "index_thesis_proposals_on_major_id"
    t.index ["semester_id"], name: "index_thesis_proposals_on_semester_id"
    t.check_constraint "max_student_count >= 1", name: "check_thesis_proposal_max_student_count"
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
    t.string "major"
    t.string "education_program"
    t.string "dkmh"
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

  add_foreign_key "defense_committees", "departments"
  add_foreign_key "defense_committees", "semesters"
  add_foreign_key "defense_committees_members", "defense_committees"
  add_foreign_key "defense_committees_members", "users", column: "lecturer_id"
  add_foreign_key "departments", "faculties"
  add_foreign_key "major_committee_members", "major_committees"
  add_foreign_key "major_committee_members", "users", column: "lecturer_id"
  add_foreign_key "major_committees", "majors"
  add_foreign_key "major_compositions", "majors", column: "multi_major_id"
  add_foreign_key "major_compositions", "majors", column: "single_major_id"
  add_foreign_key "majors", "faculties"
  add_foreign_key "theses", "defense_committees"
  add_foreign_key "theses", "semesters"
  add_foreign_key "theses_advisor_evaluations", "theses_members"
  add_foreign_key "theses_advisors", "theses"
  add_foreign_key "theses_advisors", "users", column: "lecturer_id"
  add_foreign_key "theses_members", "users", column: "student_id"
  add_foreign_key "theses_midterm_evaluations", "theses_members", column: "member_id"
  add_foreign_key "theses_reviewer_evaluations", "theses_members"
  add_foreign_key "thesis_proposal_advisors", "thesis_proposals"
  add_foreign_key "thesis_proposal_advisors", "users", column: "lecturer_id"
  add_foreign_key "thesis_proposals", "majors"
  add_foreign_key "thesis_proposals", "semesters"
end
