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

ActiveRecord::Schema.define(version: 20160205113109) do

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "period_id"
    t.boolean  "attended",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "attendances", ["period_id"], name: "index_attendances_on_period_id"
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index"
  add_index "audits", ["created_at"], name: "index_audits_on_created_at"
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid"
  add_index "audits", ["user_id", "user_type"], name: "user_index"

  create_table "course_elements", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "theme"
    t.string   "element_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "course_elements", ["course_id"], name: "index_course_elements_on_course_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["course_id"], name: "index_groups_on_course_id"

  create_table "homeworks", force: :cascade do |t|
    t.text     "review"
    t.integer  "grade"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "hw_archive_file_name"
    t.string   "hw_archive_content_type"
    t.integer  "hw_archive_file_size"
    t.datetime "hw_archive_updated_at"
    t.integer  "period_id"
    t.integer  "user_id"
  end

  add_index "homeworks", ["period_id"], name: "index_homeworks_on_period_id"
  add_index "homeworks", ["user_id"], name: "index_homeworks_on_user_id"

  create_table "periods", force: :cascade do |t|
    t.integer  "course_element_id"
    t.datetime "commence_datetime"
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "group_id"
    t.integer  "course_id"
    t.datetime "deadline"
    t.integer  "study_unit_id"
  end

  add_index "periods", ["course_element_id"], name: "index_periods_on_course_element_id"
  add_index "periods", ["course_id"], name: "index_periods_on_course_id"
  add_index "periods", ["group_id"], name: "index_periods_on_group_id"
  add_index "periods", ["study_unit_id"], name: "index_periods_on_study_unit_id"

  create_table "readings", force: :cascade do |t|
    t.string   "title"
    t.integer  "course_element_id"
    t.string   "file_id"
    t.string   "alternate_link"
    t.string   "permission_id"
    t.string   "icon_link"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "readings", ["course_element_id"], name: "index_readings_on_course_element_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "study_units", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supports_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "active",     default: true
    t.integer  "group_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "supports_groups", ["group_id"], name: "index_supports_groups_on_group_id"
  add_index "supports_groups", ["user_id"], name: "index_supports_groups_on_user_id"

  create_table "teachers_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "teachers_groups", ["group_id"], name: "index_teachers_groups_on_group_id"
  add_index "teachers_groups", ["user_id"], name: "index_teachers_groups_on_user_id"

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "middlename"
    t.string   "gender"
    t.date     "birthdate"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "skype"
    t.string   "passportdetails"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["role_id"], name: "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id"], name: "index_users_roles_on_user_id"

end
