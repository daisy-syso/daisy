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

ActiveRecord::Schema.define(version: 20151206100501) do

  create_table "accounts", force: :cascade do |t|
    t.string   "type",                   limit: 255
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "authentication_token",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "accounts", ["authentication_token"], name: "index_accounts_on_authentication_token", unique: true, using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["type", "id"], name: "index_accounts_on_type_and_id", unique: true, using: :btree

  create_table "andrology_charges", force: :cascade do |t|
    t.integer  "andrology_type_id",   limit: 4
    t.string   "name",                limit: 255
    t.string   "pice",                limit: 255
    t.string   "andrology_type_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "andrology_onsales", force: :cascade do |t|
    t.integer  "hospital_id", limit: 4
    t.integer  "type_id",     limit: 4
    t.integer  "appointment", limit: 4
    t.integer  "rebate",      limit: 4
    t.string   "name",        limit: 255
    t.string   "price",       limit: 255
    t.string   "sales",       limit: 255
    t.text     "desc",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "andrology_types", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_information_types", force: :cascade do |t|
    t.string "name", limit: 50
  end

  create_table "app_informations", force: :cascade do |t|
    t.integer "type_id",   limit: 4
    t.string  "name",      limit: 50
    t.string  "image_url", limit: 255
    t.text    "detail",    limit: 65535
    t.string  "url",       limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "characteristic_hospitals", force: :cascade do |t|
    t.integer "characteristic_id", limit: 4
    t.integer "hospital_id",       limit: 4
  end

  create_table "characteristic_hospitals_backup", force: :cascade do |t|
    t.integer "characteristic_id", limit: 4
    t.integer "hospital_id",       limit: 4
  end

  create_table "characteristics", force: :cascade do |t|
    t.string "name",          limit: 50
    t.string "name_initials", limit: 50
  end

  create_table "charge_resources", force: :cascade do |t|
    t.integer  "province_id", limit: 4
    t.integer  "city_id",     limit: 4
    t.string   "url",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.integer  "index",       limit: 4
    t.integer  "province_id", limit: 4
    t.string   "name",        limit: 255
    t.string   "initial",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "content",      limit: 255
    t.integer  "rating",       limit: 4
    t.integer  "comment_type", limit: 4
    t.integer  "hospital_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",      limit: 4
  end

  add_index "comments", ["hospital_id"], name: "index_comments_on_hospital_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "commercial_backup", force: :cascade do |t|
    t.string   "sex",              limit: 50
    t.string   "demand",           limit: 255
    t.string   "classification",   limit: 255
    t.string   "characteristic",   limit: 255
    t.string   "quota",            limit: 255
    t.string   "company",          limit: 255
    t.integer  "company_id",       limit: 4
    t.string   "age",              limit: 255
    t.string   "name",             limit: 255
    t.string   "insurance_period", limit: 255
    t.string   "price",            limit: 255
    t.integer  "appointment",      limit: 4
    t.integer  "rebate",           limit: 4
    t.text     "detail",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commercial_insurances", force: :cascade do |t|
    t.string   "sex",              limit: 50
    t.string   "demand",           limit: 255
    t.string   "classification",   limit: 255
    t.string   "characteristic",   limit: 255
    t.string   "quota",            limit: 255
    t.string   "company",          limit: 255
    t.integer  "company_id",       limit: 4
    t.string   "age",              limit: 255
    t.string   "name",             limit: 255
    t.string   "insurance_period", limit: 255
    t.string   "price",            limit: 255
    t.string   "ori_price",        limit: 255
    t.integer  "appointment",      limit: 4
    t.integer  "rebate",           limit: 4
    t.text     "detail",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "common_diseases", force: :cascade do |t|
    t.string "name",          limit: 50
    t.string "name_initials", limit: 50
  end

  create_table "confinement_centers", force: :cascade do |t|
    t.integer  "city_id",       limit: 4
    t.integer  "county_id",     limit: 4
    t.string   "name",          limit: 255
    t.string   "address",       limit: 255
    t.string   "telephone",     limit: 255
    t.string   "url",           limit: 255
    t.string   "initial",       limit: 255
    t.string   "price",         limit: 255
    t.decimal  "ori_price",                 precision: 20, scale: 2
    t.string   "image_url",     limit: 255
    t.string   "category",      limit: 255
    t.string   "introduction",  limit: 500
    t.float    "lng",           limit: 53
    t.float    "lat",           limit: 53
    t.string   "geohash",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",          limit: 24,                           default: 0.0
    t.integer  "reviews_count", limit: 4,                            default: 0
    t.integer  "status",        limit: 4,                            default: 1
    t.integer  "click_count",   limit: 4,                            default: 1
  end

  add_index "confinement_centers", ["city_id"], name: "index_confinement_centers_on_city_id", using: :btree
  add_index "confinement_centers", ["reviews_count"], name: "index_confinement_centers_on_reviews_count", using: :btree
  add_index "confinement_centers", ["star"], name: "index_confinement_centers_on_star", using: :btree

  create_table "counties", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.string   "item_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["item_id", "item_type"], name: "index_coupons_on_item_id_and_item_type", using: :btree

  create_table "dental_charges", force: :cascade do |t|
    t.integer  "dental_type_id",   limit: 4
    t.string   "name",             limit: 255
    t.string   "pice",             limit: 255
    t.string   "dental_type_name", limit: 255
    t.text     "desc",             limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dental_onsales", force: :cascade do |t|
    t.integer  "type_id",     limit: 4
    t.integer  "hospital_id", limit: 4
    t.integer  "appointment", limit: 4
    t.integer  "rebate",      limit: 4
    t.string   "name",        limit: 255
    t.string   "price",       limit: 255
    t.string   "sales",       limit: 255
    t.text     "desc",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dental_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disease_commons", force: :cascade do |t|
    t.integer "disease_id", limit: 4
    t.integer "common_id",  limit: 4
  end

  create_table "disease_details", force: :cascade do |t|
    t.integer "parent_id", limit: 4
    t.string  "title",     limit: 50
    t.text    "detail",    limit: 65535
  end

  create_table "disease_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disease_types", ["parent_id"], name: "index_disease_types_on_parent_id", using: :btree

  create_table "diseases", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "name_initials",   limit: 255
    t.string   "image_url",       limit: 255
    t.text     "etiology",        limit: 65535
    t.text     "symptoms",        limit: 65535
    t.text     "examination",     limit: 65535
    t.text     "treatment",       limit: 65535
    t.text     "prevention",      limit: 65535
    t.text     "diet",            limit: 65535
    t.text     "desc",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "disease_type_id", limit: 4
  end

  add_index "diseases", ["disease_type_id"], name: "index_diseases_on_disease_type_id", using: :btree

  create_table "diseases_doctors", force: :cascade do |t|
    t.integer  "doctor_id",  limit: 4, null: false
    t.integer  "disease_id", limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diseases_doctors", ["disease_id"], name: "index_diseases_doctors_on_disease_id", using: :btree
  add_index "diseases_doctors", ["doctor_id"], name: "index_diseases_doctors_on_doctor_id", using: :btree

  create_table "diseases_drugs", force: :cascade do |t|
    t.integer  "drug_id",    limit: 4, null: false
    t.integer  "disease_id", limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diseases_drugs", ["disease_id"], name: "index_diseases_drugs_on_disease_id", using: :btree
  add_index "diseases_drugs", ["drug_id"], name: "index_diseases_drugs_on_drug_id", using: :btree

  create_table "diseases_hospital_rooms", force: :cascade do |t|
    t.integer  "disease_id",       limit: 4
    t.integer  "hospital_room_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_hospitals", id: false, force: :cascade do |t|
    t.integer  "hospital_id", limit: 4, null: false
    t.integer  "disease_id",  limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_symptoms", force: :cascade do |t|
    t.integer  "disease_id", limit: 4
    t.integer  "symptom_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_types", force: :cascade do |t|
    t.integer "disease_id",       limit: 4
    t.integer "disease_types_id", limit: 4
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "name_initials",      limit: 255
    t.integer  "hospital_id",        limit: 4
    t.integer  "hospital_room_id",   limit: 4
    t.string   "position",           limit: 255
    t.string   "nationality",        limit: 255
    t.integer  "is_insurance",       limit: 1
    t.boolean  "is_best_reputation"
    t.string   "hospital_room",      limit: 255
    t.text     "desc",               limit: 65535
    t.string   "image_url",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drugstore_id",       limit: 4
    t.float    "star",               limit: 24,    default: 0.0
    t.integer  "reviews_count",      limit: 4,     default: 0
    t.integer  "status",             limit: 4,     default: 1
    t.integer  "click_count",        limit: 4,     default: 1
    t.string   "hospital_name",      limit: 255
    t.string   "hospital_room_name", limit: 255
  end

  add_index "doctors", ["drugstore_id"], name: "index_doctors_on_drugstore_id", using: :btree
  add_index "doctors", ["hospital_id"], name: "index_doctors_on_hospital_id", using: :btree
  add_index "doctors", ["hospital_room_id"], name: "index_doctors_on_hospital_room_id", using: :btree
  add_index "doctors", ["reviews_count"], name: "index_doctors_on_reviews_count", using: :btree
  add_index "doctors", ["star"], name: "index_doctors_on_star", using: :btree

  create_table "down_prices", force: :cascade do |t|
    t.integer  "drug_id",    limit: 4
    t.float    "price",      limit: 24
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "down_prices", ["drug_id"], name: "index_down_prices_on_drug_id", using: :btree

  create_table "drug_details", force: :cascade do |t|
    t.integer "drug_id", limit: 4
    t.string  "title",   limit: 50
    t.text    "detail",  limit: 65535
  end

  add_index "drug_details", ["drug_id"], name: "parent_id", using: :btree

  create_table "drug_manufactory_stores", force: :cascade do |t|
    t.integer "drug_id",        limit: 4
    t.integer "manufactory_id", limit: 4
    t.integer "drugstore_id",   limit: 4
    t.string  "price",          limit: 50
    t.string  "pinyin",         limit: 50
    t.string  "english_name",   limit: 50
    t.text    "introduction",   limit: 65535
  end

  create_table "drug_type", force: :cascade do |t|
    t.string  "name",      limit: 50
    t.integer "parent_id", limit: 4
    t.integer "typeid",    limit: 4
  end

  create_table "drug_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "disease_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drug_types", ["parent_id"], name: "index_drug_types_on_parent_id", using: :btree

  create_table "drugs", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "manufactory",          limit: 255
    t.decimal  "ori_price",                          precision: 20, scale: 2
    t.decimal  "price",                              precision: 20, scale: 2
    t.decimal  "extension",                          precision: 20, scale: 2
    t.text     "introduction",         limit: 65535
    t.integer  "sales_volume",         limit: 8
    t.string   "image_url",            limit: 255
    t.integer  "drug_type_id",         limit: 4
    t.integer  "drug_type_two_id",     limit: 4
    t.string   "brand",                limit: 255
    t.string   "code",                 limit: 255
    t.string   "expiry_date",          limit: 255
    t.string   "spec",                 limit: 255
    t.string   "dosage",               limit: 255
    t.string   "is_store",             limit: 255
    t.string   "name_initials",        limit: 255
    t.string   "manufactory_initials", limit: 255
    t.integer  "disease_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_insurance"
    t.integer  "is_otc",               limit: 4
    t.boolean  "is_prescription"
    t.boolean  "is_westren"
    t.boolean  "is_show"
    t.float    "star",                 limit: 24,                             default: 0.0
    t.integer  "reviews_count",        limit: 4,                              default: 0
    t.integer  "editor_id",            limit: 4
  end

  add_index "drugs", ["disease_id"], name: "index_drugs_on_disease_id", using: :btree
  add_index "drugs", ["drug_type_id"], name: "index_drugs_on_drug_type_id", using: :btree
  add_index "drugs", ["editor_id"], name: "index_drugs_on_editor_id", using: :btree
  add_index "drugs", ["extension"], name: "extension", using: :btree
  add_index "drugs", ["manufactory"], name: "manufactory", using: :btree
  add_index "drugs", ["name"], name: "name", using: :btree
  add_index "drugs", ["reviews_count"], name: "index_drugs_on_reviews_count", using: :btree
  add_index "drugs", ["spec"], name: "spec", using: :btree
  add_index "drugs", ["star"], name: "index_drugs_on_star", using: :btree

  create_table "drugs_hospital_rooms", force: :cascade do |t|
    t.integer "drug_id",          limit: 4
    t.integer "hospital_room_id", limit: 4
  end

  create_table "drugs_types", force: :cascade do |t|
    t.integer "drug_type_id", limit: 4
    t.integer "drug_id",      limit: 4
  end

  add_index "drugs_types", ["drug_id"], name: "index_drugs_types_on_drug_id", using: :btree
  add_index "drugs_types", ["drug_type_id"], name: "index_drugs_types_on_drug_type_id", using: :btree

  create_table "drugs_users", force: :cascade do |t|
    t.integer  "drug_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugstore_users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "account",                limit: 255
    t.string   "password",               limit: 255
    t.datetime "first_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "drugstore_users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "drugstore_users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "drugstores", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "address",           limit: 255
    t.string   "telephone",         limit: 255
    t.string   "image_url",         limit: 255
    t.string   "name_initials",     limit: 255
    t.string   "url",               limit: 255
    t.string   "GSP",               limit: 255
    t.string   "Business_License",  limit: 255
    t.string   "License",           limit: 255
    t.string   "License_Time",      limit: 255
    t.string   "Scope_of_business", limit: 500
    t.integer  "city_id",           limit: 4
    t.integer  "county_id",         limit: 4
    t.boolean  "is_local_hot"
    t.boolean  "is_insurance"
    t.boolean  "is_national_hot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lng",               limit: 53
    t.float    "lat",               limit: 53
    t.decimal  "extension",                     precision: 20, scale: 2
    t.string   "geohash",           limit: 255
    t.float    "star",              limit: 24,                           default: 0.0
    t.integer  "reviews_count",     limit: 4,                            default: 0
    t.integer  "status",            limit: 4,                            default: 1
    t.integer  "click_count",       limit: 4,                            default: 1
    t.integer  "editor_id",         limit: 4
  end

  add_index "drugstores", ["city_id"], name: "index_drugstores_on_city_id", using: :btree
  add_index "drugstores", ["editor_id"], name: "index_drugstores_on_editor_id", using: :btree
  add_index "drugstores", ["geohash"], name: "index_drugstores_on_geohash", using: :btree
  add_index "drugstores", ["name"], name: "name", using: :btree
  add_index "drugstores", ["reviews_count"], name: "index_drugstores_on_reviews_count", using: :btree
  add_index "drugstores", ["star"], name: "index_drugstores_on_star", using: :btree

  create_table "drugstores_drugs", force: :cascade do |t|
    t.integer "drugstore_id", limit: 4
    t.integer "drug_id",      limit: 4
  end

  create_table "drugstores_users", force: :cascade do |t|
    t.integer  "drugstore_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.string   "drug_price",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "e_drugs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.float    "ori_price",      limit: 24
    t.float    "price",          limit: 24
    t.string   "manufactory",    limit: 255
    t.string   "introduction",   limit: 255
    t.string   "image_url",      limit: 255
    t.string   "brand",          limit: 255
    t.string   "code",           limit: 255
    t.string   "expiry_date",    limit: 255
    t.string   "spec",           limit: 255
    t.integer  "editor_id",      limit: 4
    t.integer  "e_drugstore_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drug_type_id",   limit: 4
  end

  add_index "e_drugs", ["e_drugstore_id"], name: "index_e_drugs_on_e_drugstore_id", using: :btree
  add_index "e_drugs", ["editor_id"], name: "index_e_drugs_on_editor_id", using: :btree
  add_index "e_drugs", ["name"], name: "index_e_drugs_on_name", using: :btree

  create_table "e_drugstores", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "address",          limit: 255
    t.string   "telephone",        limit: 255
    t.string   "image_url",        limit: 255
    t.float    "lng",              limit: 24
    t.float    "lat",              limit: 24
    t.integer  "city_id",          limit: 4
    t.integer  "county_id",        limit: 4
    t.integer  "editor_id",        limit: 4
    t.string   "business_license", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",          limit: 255
    t.string   "description",      limit: 255
  end

  add_index "e_drugstores", ["city_id"], name: "index_e_drugstores_on_city_id", using: :btree
  add_index "e_drugstores", ["county_id"], name: "index_e_drugstores_on_county_id", using: :btree
  add_index "e_drugstores", ["editor_id"], name: "index_e_drugstores_on_editor_id", using: :btree
  add_index "e_drugstores", ["name"], name: "index_e_drugstores_on_name", using: :btree

  create_table "editors", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.string   "username",      limit: 255
    t.string   "telephone",     limit: 255
    t.string   "password_hash", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editors_roles", id: false, force: :cascade do |t|
    t.integer "editor_id", limit: 4
    t.integer "role_id",   limit: 4
  end

  add_index "editors_roles", ["editor_id", "role_id"], name: "index_editors_roles_on_editor_id_and_role_id", using: :btree

  create_table "eldercares", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "address",         limit: 255
    t.string   "telephone",       limit: 255
    t.string   "image_url",       limit: 255
    t.integer  "city_id",         limit: 4
    t.boolean  "is_local_hot"
    t.boolean  "is_national_hot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eldercares", ["city_id"], name: "index_eldercares_on_city_id", using: :btree

  create_table "endowment_services", force: :cascade do |t|
    t.integer  "endowment_id", limit: 4,   default: 0
    t.string   "name",         limit: 255
    t.string   "url",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "endowments", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "examination_charges", force: :cascade do |t|
    t.integer "examination_type_id", limit: 4
    t.string  "min_price",           limit: 50
    t.string  "max_price",           limit: 50
  end

  create_table "examination_details", force: :cascade do |t|
    t.integer "parent_id", limit: 4
    t.string  "types",     limit: 50
    t.string  "title",     limit: 500
    t.text    "content",   limit: 65535
  end

  create_table "examination_reminds", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.text    "desc",      limit: 65535
    t.integer "parent_id", limit: 4
  end

  create_table "examination_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examination_types", ["parent_id"], name: "index_examination_types_on_parent_id", using: :btree

  create_table "examinations", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.integer  "examination_type_id",        limit: 4
    t.integer  "examination_type_parent_id", limit: 4
    t.integer  "city_id",                    limit: 4
    t.integer  "hospital_id",                limit: 4
    t.integer  "appointment",                limit: 4
    t.integer  "rebate",                     limit: 4
    t.string   "hospital_name",              limit: 255
    t.string   "applicable",                 limit: 255
    t.string   "feature",                    limit: 255
    t.string   "image_url",                  limit: 255
    t.float    "price",                      limit: 24
    t.float    "save_price",                 limit: 24
    t.string   "geohash",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",                       limit: 24,  default: 0.0
    t.integer  "reviews_count",              limit: 4,   default: 0
  end

  add_index "examinations", ["city_id"], name: "index_examinations_on_city_id", using: :btree
  add_index "examinations", ["examination_type_id"], name: "index_examinations_on_examination_type_id", using: :btree
  add_index "examinations", ["geohash"], name: "index_examinations_on_geohash", using: :btree
  add_index "examinations", ["reviews_count"], name: "index_examinations_on_reviews_count", using: :btree
  add_index "examinations", ["star"], name: "index_examinations_on_star", using: :btree

  create_table "examinations_hospitals", force: :cascade do |t|
    t.integer "examination_id",             limit: 4
    t.integer "examination_type_id",        limit: 4
    t.integer "examination_type_parent_id", limit: 4
    t.integer "hospital_id",                limit: 4
  end

  create_table "examinations_new", force: :cascade do |t|
    t.string  "name",                    limit: 50
    t.text    "address",                 limit: 65535
    t.integer "examination_type_one_id", limit: 4
    t.integer "examination_type_two_id", limit: 4
    t.integer "city_id",                 limit: 4
    t.integer "hospital_id",             limit: 4
    t.string  "hospital_name",           limit: 50
    t.string  "image_url",               limit: 508
    t.string  "price",                   limit: 508
    t.integer "star",                    limit: 4
    t.integer "reviews_count",           limit: 4
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "account_id", limit: 4
    t.integer  "item_id",    limit: 4
    t.string   "item_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["account_id"], name: "index_favorites_on_account_id", using: :btree
  add_index "favorites", ["item_id", "item_type"], name: "index_favorites_on_item_id_and_item_type", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "content",        limit: 255
    t.integer  "e_drugstore_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "feedbacks", ["e_drugstore_id"], name: "index_feedbacks_on_e_drugstore_id", using: :btree

  create_table "friendly_link_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "friendly_links", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.integer  "friendly_link_type_id", limit: 4
    t.string   "url",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendly_links", ["friendly_link_type_id"], name: "index_friendly_links_on_friendly_link_type_id", using: :btree

  create_table "gynaecology_charges", force: :cascade do |t|
    t.integer  "gynaecology_type_id",   limit: 4
    t.string   "name",                  limit: 50
    t.string   "gynaecology_type_name", limit: 50
    t.string   "pice",                  limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gynaecology_onsales", force: :cascade do |t|
    t.integer  "type_id",     limit: 4
    t.string   "name",        limit: 255
    t.integer  "hospital_id", limit: 4
    t.integer  "appointment", limit: 4
    t.integer  "rebate",      limit: 4
    t.string   "price",       limit: 255
    t.string   "sales",       limit: 255
    t.text     "desc",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gynaecology_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "halls", force: :cascade do |t|
    t.integer  "city_id",    limit: 4
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "image_url",  limit: 255
    t.float    "lng",        limit: 53
    t.float    "lat",        limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hamburgers", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.string   "image_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_information_types", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.string   "image_url",  limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_informations", force: :cascade do |t|
    t.integer  "type_id",       limit: 4
    t.string   "name",          limit: 255
    t.string   "url",           limit: 255
    t.string   "image_url",     limit: 255
    t.integer  "flag",          limit: 4
    t.text     "content",       limit: 65535
    t.float    "star",          limit: 24
    t.integer  "reviews_count", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_charges", force: :cascade do |t|
    t.integer  "herbalist_doctor_type_id",   limit: 4
    t.string   "name",                       limit: 255
    t.string   "pice",                       limit: 255
    t.string   "duration",                   limit: 255
    t.string   "herbalist_doctor_type_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_onsales", force: :cascade do |t|
    t.integer  "hall_id",     limit: 4
    t.integer  "type_id",     limit: 4
    t.integer  "appointment", limit: 4
    t.integer  "rebate",      limit: 4
    t.string   "name",        limit: 255
    t.string   "price",       limit: 255
    t.string   "sales",       limit: 255
    t.text     "desc",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_types", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospital_charges", force: :cascade do |t|
    t.integer  "hospital_type_parent_id", limit: 4
    t.integer  "hospital_type_id",        limit: 4
    t.string   "name",                    limit: 255
    t.string   "project",                 limit: 255
    t.string   "price_scope",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_charges", ["hospital_type_id"], name: "hospital_type_id", using: :btree
  add_index "hospital_charges", ["name"], name: "name", using: :btree

  create_table "hospital_doctors", force: :cascade do |t|
    t.integer "hospital_id", limit: 4
    t.integer "doctor_id",   limit: 4
  end

  create_table "hospital_levels", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "hospital_levels", ["id"], name: "index_hospital_levels_on_id_and_position", using: :btree

  create_table "hospital_news", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "url",              limit: 255
    t.integer  "hospital_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_news", ["hospital_type_id"], name: "index_hospital_type_news_on_hospital_type_id", using: :btree

  create_table "hospital_onsales", force: :cascade do |t|
    t.integer  "hospital_id",        limit: 4
    t.integer  "hospital_charge_id", limit: 4
    t.integer  "extension",          limit: 4
    t.integer  "appointment",        limit: 4
    t.integer  "rebate",             limit: 4
    t.integer  "sales_volume",       limit: 8
    t.string   "name",               limit: 255
    t.string   "price",              limit: 50
    t.string   "ori_price",          limit: 50
    t.string   "sales",              limit: 255
    t.string   "original_price",     limit: 255
    t.string   "image_url",          limit: 255
    t.string   "discount",           limit: 255
    t.text     "desc",               limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thumb",              limit: 4
    t.float    "star",               limit: 24
    t.integer  "reviews_count",      limit: 4
    t.integer  "click_count",        limit: 4
  end

  create_table "hospital_rooms", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_rooms", ["parent_id"], name: "index_hospital_rooms_on_parent_id", using: :btree

  create_table "hospital_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "filter",     limit: 4
    t.string   "image_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitalinfo", force: :cascade do |t|
    t.string "chengshi", limit: 255
    t.string "name",     limit: 255
    t.string "dengji",   limit: 255
    t.text   "jianjie",  limit: 65535
    t.text   "address",  limit: 65535
    t.string "tel",      limit: 255
    t.string "pic",      limit: 500
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "telephone",                  limit: 255
    t.string   "address",                    limit: 255
    t.string   "image_url",                  limit: 255
    t.string   "url",                        limit: 255
    t.string   "mobile_url",                 limit: 255
    t.string   "medical_insurance",          limit: 255
    t.string   "characteristic_departments", limit: 255
    t.integer  "city_id",                    limit: 4
    t.integer  "county_id",                  limit: 4
    t.integer  "specialist",                 limit: 4
    t.boolean  "is_local_hot"
    t.boolean  "is_national_hot"
    t.boolean  "is_best_reputation"
    t.boolean  "is_best"
    t.decimal  "extension",                                precision: 20, scale: 2
    t.string   "level",                      limit: 255
    t.integer  "click_count",                limit: 4,                              default: 0
    t.float    "lng",                        limit: 53
    t.float    "lat",                        limit: 53
    t.string   "geohash",                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",                       limit: 24,                             default: 0.0
    t.integer  "reviews_count",              limit: 4,                              default: 0
    t.float    "equipment_star",             limit: 24,                             default: 0.0
    t.float    "skill_star",                 limit: 24,                             default: 0.0
    t.float    "service_star",               limit: 24,                             default: 0.0
    t.float    "environment_star",           limit: 24,                             default: 0.0
    t.text     "environment_desc",           limit: 65535
    t.text     "service_desc",               limit: 65535
    t.text     "skill_desc",                 limit: 65535
    t.text     "equipment_desc",             limit: 65535
    t.integer  "hospital_level_id",          limit: 4
    t.string   "name_initials",              limit: 50
    t.string   "bed",                        limit: 50
    t.boolean  "is_foreign"
    t.boolean  "is_community"
    t.boolean  "is_other"
    t.boolean  "is_insurance"
    t.text     "backup",                     limit: 65535
    t.text     "light",                      limit: 65535
    t.integer  "status",                     limit: 4,                              default: 1
  end

  add_index "hospitals", ["city_id"], name: "index_hospitals_on_city_id", using: :btree
  add_index "hospitals", ["click_count"], name: "index_hospitals_on_click_count", using: :btree
  add_index "hospitals", ["geohash"], name: "index_hospitals_on_geohash", using: :btree
  add_index "hospitals", ["hospital_level_id"], name: "index_hospitals_on_hospital_level_id", using: :btree
  add_index "hospitals", ["reviews_count"], name: "index_hospitals_on_reviews_count", using: :btree
  add_index "hospitals", ["star"], name: "index_hospitals_on_star", using: :btree

  create_table "hospitals_levels", force: :cascade do |t|
    t.integer  "hospital_id",       limit: 4
    t.integer  "hospital_level_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals_types", force: :cascade do |t|
    t.integer  "hospital_id",      limit: 4
    t.integer  "hospital_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospitals_types", ["hospital_id"], name: "index_hospitals_types_on_hospital_id", using: :btree
  add_index "hospitals_types", ["hospital_type_id"], name: "index_hospitals_types_on_type_id", using: :btree

  create_table "hospitals_users", force: :cascade do |t|
    t.integer  "hospital_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hot_news", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hot_search_keywords", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "content",        limit: 65535
    t.string   "image_url",      limit: 255
    t.string   "author",         limit: 255
    t.integer  "e_drugstore_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "incidents", ["e_drugstore_id"], name: "index_incidents_on_e_drugstore_id", using: :btree

  create_table "information_type", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "top_number", limit: 4,   default: 1
  end

  create_table "informations", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "information_type_id", limit: 4
    t.text     "content",             limit: 65535
    t.string   "source",              limit: 255
    t.string   "image_url",           limit: 255
    t.string   "created_at",          limit: 50
    t.datetime "updated_at"
    t.float    "star",                limit: 24
    t.integer  "reviews_count",       limit: 4
    t.integer  "read_count",          limit: 4,     default: 0
    t.boolean  "is_top",                            default: false
    t.integer  "types",               limit: 4,     default: 0
  end

  add_index "informations", ["name"], name: "name", using: :btree

  create_table "insurance_companies", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "url",  limit: 255
  end

  create_table "insurance_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "insurances", force: :cascade do |t|
    t.string  "name",                 limit: 255
    t.string  "price",                limit: 255
    t.string  "type_name",            limit: 255
    t.string  "url",                  limit: 255
    t.integer "appointment",          limit: 4
    t.integer "rebate",               limit: 4
    t.integer "insurance_type_id",    limit: 4
    t.integer "insurance_company_id", limit: 4
    t.integer "status",               limit: 4,   default: 1
  end

  add_index "insurances", ["insurance_company_id"], name: "index_insurances_on_insurance_company_id", using: :btree
  add_index "insurances", ["insurance_type_id"], name: "index_insurances_on_insurance_type_id", using: :btree

  create_table "join_applies", force: :cascade do |t|
    t.integer  "target_id",     limit: 4
    t.string   "target_type",   limit: 255
    t.string   "email",         limit: 255
    t.string   "contact_user",  limit: 255
    t.string   "contact_phone", limit: 255
    t.text     "admin_comment", limit: 65535
    t.integer  "status",        limit: 4,     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "join_applies", ["target_id", "target_type"], name: "index_join_applies_on_target_id_and_target_type", using: :btree

  create_table "manufactories", force: :cascade do |t|
    t.string  "name",                      limit: 50
    t.string  "name_initials",             limit: 50
    t.integer "city_id",                   limit: 4
    t.string  "certificate_number",        limit: 50
    t.string  "issuing_date",              limit: 50
    t.string  "validity_period",           limit: 50
    t.string  "legal_representative",      limit: 50
    t.string  "business_owners",           limit: 50
    t.string  "enterprise_type",           limit: 50
    t.text    "address",                   limit: 65535
    t.text    "production_address",        limit: 65535
    t.float   "lng",                       limit: 53
    t.float   "lat",                       limit: 53
    t.text    "production_classification", limit: 65535
    t.string  "url",                       limit: 500
    t.string  "telephone",                 limit: 50
    t.string  "image_url",                 limit: 255
    t.integer "status",                    limit: 4,     default: 1
  end

  add_index "manufactories", ["name"], name: "name", using: :btree

  create_table "manufactory_drugs", force: :cascade do |t|
    t.integer "manufactory_id", limit: 4
    t.integer "drug_id",        limit: 4
    t.string  "price_range",    limit: 50
    t.string  "code",           limit: 500
    t.string  "spec",           limit: 50
    t.string  "dosage",         limit: 50
  end

  add_index "manufactory_drugs", ["drug_id"], name: "drug_id", using: :btree
  add_index "manufactory_drugs", ["manufactory_id"], name: "manufactory_id", using: :btree

  create_table "maternal_halls", force: :cascade do |t|
    t.integer  "city_id",       limit: 4
    t.integer  "county_id",     limit: 4
    t.string   "name",          limit: 255
    t.string   "address",       limit: 255
    t.string   "telephone",     limit: 255
    t.string   "image_url",     limit: 255
    t.float    "lng",           limit: 53
    t.float    "lat",           limit: 53
    t.decimal  "ori_price",                 precision: 20, scale: 2
    t.string   "geohash",       limit: 255
    t.string   "initial",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",          limit: 24,                           default: 0.0
    t.integer  "reviews_count", limit: 4,                            default: 0
    t.integer  "status",        limit: 4,                            default: 1
    t.integer  "click_count",   limit: 4,                            default: 1
  end

  add_index "maternal_halls", ["city_id"], name: "index_maternal_halls_on_city_id", using: :btree
  add_index "maternal_halls", ["reviews_count"], name: "index_maternal_halls_on_reviews_count", using: :btree
  add_index "maternal_halls", ["star"], name: "index_maternal_halls_on_star", using: :btree

  create_table "medical_articles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "click_count", limit: 4
    t.datetime "posted_date"
    t.text     "content",     limit: 65535
    t.string   "author",      limit: 255
    t.string   "website",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_institutions", force: :cascade do |t|
    t.string  "name",        limit: 50
    t.integer "hospital_id", limit: 4
  end

  create_table "medical_posts", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "click_count", limit: 4
    t.datetime "posted_date"
    t.text     "content",     limit: 65535
    t.string   "author",      limit: 255
    t.string   "website",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_tips", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "url",              limit: 255
    t.integer  "click_count",      limit: 4
    t.datetime "posted_date"
    t.text     "content",          limit: 65535
    t.string   "author",           limit: 255
    t.string   "website",          limit: 255
    t.integer  "hospital_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_tips", ["hospital_type_id"], name: "index_medical_tips_on_hospital_type_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.integer  "seq",        limit: 4
    t.string   "icon",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["parent_id"], name: "index_menus_on_parent_id", using: :btree

  create_table "net_infos", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "image_url",        limit: 255
    t.datetime "created_at"
    t.integer  "hospital_type_id", limit: 4
  end

  add_index "net_infos", ["hospital_type_id"], name: "index_net_infos_on_hospital_type_id", using: :btree

  create_table "nursing_rooms", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "address",       limit: 255
    t.string   "telephone",     limit: 255
    t.string   "image_url",     limit: 255
    t.integer  "city_id",       limit: 4
    t.integer  "county_id",     limit: 4
    t.string   "geohash",       limit: 255
    t.string   "initial",       limit: 255
    t.string   "bed",           limit: 255
    t.string   "target",        limit: 5000
    t.string   "price",         limit: 500
    t.string   "ori_price",     limit: 500
    t.string   "light",         limit: 5000
    t.string   "nature",        limit: 500
    t.string   "mold",          limit: 500
    t.string   "url",           limit: 500
    t.text     "service",       limit: 65535
    t.text     "traffic",       limit: 65535
    t.text     "introduction",  limit: 65535
    t.float    "lat",           limit: 53
    t.float    "lng",           limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "back_up",       limit: 50
    t.float    "star",          limit: 24,    default: 0.0
    t.integer  "reviews_count", limit: 4,     default: 0
    t.integer  "status",        limit: 4,     default: 1
    t.integer  "click_count",   limit: 4,     default: 1
  end

  add_index "nursing_rooms", ["city_id"], name: "index_nursing_rooms_on_city_id", using: :btree
  add_index "nursing_rooms", ["geohash"], name: "index_nursing_rooms_on_geohash", using: :btree
  add_index "nursing_rooms", ["reviews_count"], name: "index_nursing_rooms_on_reviews_count", using: :btree
  add_index "nursing_rooms", ["star"], name: "index_nursing_rooms_on_star", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "quantity",          limit: 4
    t.float    "price",             limit: 24
    t.float    "discount",          limit: 24
    t.string   "trade_no",          limit: 255
    t.string   "provider",          limit: 255
    t.string   "state",             limit: 255
    t.string   "logistics_type",    limit: 255
    t.string   "logistics_name",    limit: 255
    t.float    "logistics_fee",     limit: 24
    t.string   "logistics_payment", limit: 255
    t.string   "transport_type",    limit: 255
    t.string   "receive_name",      limit: 255
    t.text     "receive_address",   limit: 65535
    t.string   "receive_zip",       limit: 255
    t.string   "receive_mobile",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id",        limit: 4
    t.integer  "item_id",           limit: 4
    t.string   "item_type",         limit: 255
    t.string   "name",              limit: 255
  end

  add_index "orders", ["account_id"], name: "index_orders_on_account_id", using: :btree
  add_index "orders", ["item_type", "item_id"], name: "index_orders_on_item_type_and_item_id", using: :btree

  create_table "parts", force: :cascade do |t|
    t.string "name", limit: 50, default: "0", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "picture",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id", limit: 4
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree

  create_table "polyclinic_charges", force: :cascade do |t|
    t.integer  "province_id", limit: 4
    t.string   "name",        limit: 50
    t.string   "url",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_notifications", force: :cascade do |t|
    t.integer  "account_id", limit: 4
    t.integer  "item_id",    limit: 4
    t.string   "item_type",  limit: 255
    t.float    "price",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_notifications", ["account_id"], name: "index_price_notifications_on_account_id", using: :btree
  add_index "price_notifications", ["item_id", "item_type"], name: "index_price_notifications_on_item_id_and_item_type", using: :btree

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id", limit: 4
  end

  create_table "raider_details", force: :cascade do |t|
    t.integer "parent_id", limit: 4
    t.string  "name",      limit: 50
    t.text    "details",   limit: 65535
  end

  create_table "raiders", force: :cascade do |t|
    t.string "name",   limit: 255
    t.text   "detail", limit: 65535
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "account_id",  limit: 4
    t.integer  "item_id",     limit: 4
    t.string   "item_type",   limit: 255
    t.integer  "order_id",    limit: 4
    t.integer  "star",        limit: 4
    t.text     "desc",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment", limit: 4
    t.integer  "service",     limit: 4
    t.integer  "charge",      limit: 4
    t.integer  "technique",   limit: 4
  end

  add_index "reviews", ["account_id"], name: "index_reviews_on_account_id", using: :btree
  add_index "reviews", ["item_id", "item_type"], name: "index_reviews_on_item_id_and_item_type", using: :btree
  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255,   null: false
    t.text     "value",      limit: 65535
    t.integer  "thing_id",   limit: 4
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "shaping_items", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "price_scope",       limit: 255
    t.string   "target",            limit: 255
    t.string   "operation_time",    limit: 255
    t.string   "note",              limit: 255
    t.string   "life_note",         limit: 255
    t.string   "remark",            limit: 255
    t.string   "shaping_type_name", limit: 255
    t.integer  "shaping_type_id",   limit: 4
    t.string   "image_url",         limit: 255
    t.float    "star",              limit: 24,  default: 5.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviews_count",     limit: 4,   default: 0
  end

  add_index "shaping_items", ["reviews_count"], name: "index_shaping_items_on_reviews_count", using: :btree
  add_index "shaping_items", ["shaping_type_id"], name: "index_shaping_items_on_shaping_type_id", using: :btree
  add_index "shaping_items", ["star"], name: "index_shaping_items_on_star", using: :btree

  create_table "shaping_onsales", force: :cascade do |t|
    t.integer  "type_id",     limit: 4
    t.integer  "hospital_id", limit: 4
    t.integer  "appointment", limit: 4
    t.integer  "rebate",      limit: 4
    t.string   "name",        limit: 255
    t.string   "price",       limit: 255
    t.string   "sales",       limit: 255
    t.string   "desc",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shaping_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.string   "desc",       limit: 255
    t.string   "image_url",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shaping_types", ["parent_id"], name: "index_shaping_types_on_parent_id", using: :btree

  create_table "social_securities", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "city_id",                 limit: 4
    t.integer  "province_id",             limit: 4
    t.integer  "social_security_type_id", limit: 4
    t.string   "url",                     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_securities", ["city_id"], name: "index_social_securities_on_city_id", using: :btree
  add_index "social_securities", ["province_id"], name: "index_social_securities_on_province_id", using: :btree

  create_table "social_security_types", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "stat_daily_ips", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.integer  "count",      limit: 4
    t.integer  "city_id",    limit: 4
    t.date     "occur_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stat_daily_ips", ["city_id"], name: "index_stat_daily_ips_on_city_id", using: :btree

  create_table "symptom_details", force: :cascade do |t|
    t.string "title",     limit: 255
    t.string "detail_id", limit: 255
    t.text   "detail",    limit: 65535
    t.string "image_url", limit: 255
  end

  create_table "symptoms", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "name_initials", limit: 255
    t.integer  "part_id",       limit: 4
    t.string   "xgjc",          limit: 255
    t.string   "detail_id",     limit: 255
    t.string   "xgzz",          limit: 255
    t.string   "xgyp",          limit: 255
    t.string   "xgjb",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age",        limit: 4
    t.text     "desc",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp", id: false, force: :cascade do |t|
    t.integer "id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "account",                limit: 255
    t.string   "password",               limit: 255
    t.datetime "first_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
