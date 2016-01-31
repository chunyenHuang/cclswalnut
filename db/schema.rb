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
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appraisals", force: true do |t|
    t.integer  "number"
    t.string   "itemnumber"
    t.string   "descritption"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "castinglogs", force: true do |t|
    t.string   "weight_today"
    t.string   "weight_lasttime"
    t.string   "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classdocuments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classinfos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classlists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "customer_name"
    t.string   "customer_number"
    t.string   "customer_address"
    t.integer  "customer_zipcode"
    t.string   "customer_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "detailsheets", force: true do |t|
    t.string   "weight"
    t.string   "side1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluationteachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golds", force: true do |t|
    t.string   "invoicenumber"
    t.float    "Y18"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.integer  "tuition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.date     "from_date"
    t.date     "to_date"
    t.string   "rushnote"
    t.string   "ordernumber"
    t.string   "category"
    t.string   "gold"
    t.float    "size"
    t.integer  "quantity"
    t.text     "description"
    t.string   "picture"
    t.string   "caddesigners"
    t.string   "string"
    t.string   "setters"
    t.string   "status_factory"
    t.string   "status_shipping"
    t.string   "customer_name"
    t.string   "customer_phone"
    t.integer  "itemnumber"
    t.integer  "invoicenumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stones", force: true do |t|
    t.string   "report"
    t.integer  "orderlist_id"
    t.string   "shape"
    t.float    "size"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacherdocuments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "textbooks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
