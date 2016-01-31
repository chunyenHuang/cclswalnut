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

ActiveRecord::Schema.define(version: 20160115055359) do

  create_table "activities", force: true do |t|
    t.string   "name_english"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "Field6"
    t.string   "name_chinese"
    t.string   "place"
    t.string   "place_address"
    t.string   "date_begin"
    t.string   "date_end"
    t.integer  "Field12"
  end

  create_table "classdocuments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "classlist_id"
    t.integer  "teacher_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "document"
    t.string   "note"
  end

  create_table "classinfos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
    t.integer  "classlist_id"
    t.string   "class_name"
    t.integer  "note"
    t.boolean  "check_pay"
    t.integer  "tuition"
    t.string   "midterm"
    t.string   "final"
    t.string   "quiz1"
    t.string   "quiz2"
    t.string   "quiz3"
    t.string   "quiz4"
    t.string   "quiz5"
    t.integer  "Field18"
    t.integer  "Field19"
  end

  create_table "classlists", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "year"
    t.string   "class_name"
    t.string   "kind"
    t.string   "place"
    t.integer  "tuition"
    t.integer  "tuition_count"
    t.string   "note"
    t.date     "date_from"
    t.date     "date_to"
    t.time     "time_from"
    t.time     "time_to"
  end

  create_table "evaluationteachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "classlist_id"
    t.float    "grade"
    t.float    "rate"
    t.string   "note"
    t.integer  "Field9"
    t.integer  "Field10"
  end

  create_table "members", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "father_name_chinese"
    t.string   "father_firstname"
    t.string   "father_lastname"
    t.string   "father_middlename"
    t.string   "mother_name_chinese"
    t.string   "mother_firstname"
    t.string   "mother_lastname"
    t.string   "mother_middlename"
    t.string   "father_phone1"
    t.string   "father_phone2"
    t.string   "father_phone3"
    t.string   "mother_phone1"
    t.string   "mother_phone2"
    t.string   "mother_phone3"
    t.string   "address1_street"
    t.string   "address1_city"
    t.string   "address1_state"
    t.integer  "address1_zipcode"
    t.string   "address2_street"
    t.string   "address2_city"
    t.string   "address2_state"
    t.integer  "address2_zipcode"
    t.string   "father_email1"
    t.string   "father_email2"
    t.string   "mother_email1"
    t.string   "mother_email2"
    t.string   "father_picture"
    t.string   "mother_picture"
    t.boolean  "check_address_same"
    t.integer  "user_id"
    t.string   "user_name"
  end

  create_table "payments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "member_id"
    t.float    "amount"
    t.integer  "checknumber"
    t.boolean  "cash"
    t.string   "note"
    t.string   "picture1"
    t.string   "picture2"
    t.string   "picture3"
    t.string   "picture4"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "searches", force: true do |t|
    t.string   "keywords"
    t.string   "getorderday"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gold"
    t.string   "size"
    t.string   "caddesigners"
    t.string   "setters"
    t.string   "status_factory"
    t.string   "order_of"
    t.integer  "itemnumber"
    t.string   "invoicenumber"
    t.string   "ordernumber"
    t.datetime "from_date"
    t.datetime "to_date"
    t.string   "customer_name"
    t.float    "center_carat"
    t.integer  "customer_id"
  end

  create_table "stones", force: true do |t|
    t.integer  "orderlist_id"
    t.string   "kind"
    t.string   "color"
    t.string   "shape"
    t.float    "size"
    t.integer  "amount"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "part1"
    t.string   "part2"
    t.string   "part3"
    t.string   "part4"
    t.string   "part5"
    t.string   "part6"
    t.string   "part7"
  end

  create_table "students", force: true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.integer  "teacher_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_chinese"
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "nickname"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "email1"
    t.string   "email2"
    t.string   "school_elementary"
    t.string   "school_junior"
    t.string   "school_high"
    t.string   "address"
    t.date     "birthday"
    t.string   "picture1"
    t.string   "picture2"
    t.string   "note"
  end

  create_table "teacherdocuments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.string   "file"
    t.string   "note"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",          null: false
    t.boolean  "check_teacher"
    t.boolean  "check_member"
    t.boolean  "check_staff"
    t.string   "position"
    t.binary   "encrypted_password",     default: "x'782727'", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "middlename"
    t.string   "phone_mobile"
    t.string   "phone_home"
    t.string   "phone_work"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zipcode"
    t.string   "pic1"
    t.string   "pic2"
    t.string   "pic3"
    t.string   "contact1_name"
    t.string   "contact1_phone"
    t.string   "contact1_relationship"
    t.string   "contact2_name"
    t.string   "contact2_phone"
    t.string   "contact2_relationship"
    t.string   "note"
    t.string   "document1"
    t.string   "document2"
    t.string   "document3"
  end

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
