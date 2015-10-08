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

ActiveRecord::Schema.define(version: 20151007032359) do

  create_table "accounts", force: true do |t|
    t.string   "type"
    t.string   "username",               default: "", null: false
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
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "accounts", ["authentication_token"], name: "index_accounts_on_authentication_token", unique: true, using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["type", "id"], name: "index_accounts_on_type_and_id", unique: true, using: :btree

  create_table "andrology_charges", force: true do |t|
    t.integer  "andrology_type_id"
    t.string   "name"
    t.string   "pice"
    t.string   "andrology_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "andrology_onsales", force: true do |t|
    t.integer  "hospital_id"
    t.integer  "type_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "name"
    t.string   "price"
    t.string   "sales"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "andrology_types", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_information_types", force: true do |t|
    t.string "name", limit: 50
  end

  create_table "app_informations", force: true do |t|
    t.integer "type_id"
    t.string  "name",      limit: 50
    t.string  "image_url"
    t.text    "detail"
    t.string  "url"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "characteristic_hospitals", force: true do |t|
    t.integer "characteristic_id"
    t.integer "hospital_id"
  end

  create_table "characteristic_hospitals_backup", force: true do |t|
    t.integer "characteristic_id"
    t.integer "hospital_id"
  end

  create_table "characteristics", force: true do |t|
    t.string "name",          limit: 50
    t.string "name_initials", limit: 50
  end

  create_table "charge_resources", force: true do |t|
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.integer  "index"
    t.integer  "province_id"
    t.string   "name"
    t.string   "initial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "rating"
    t.integer  "comment_type"
    t.integer  "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["hospital_id"], name: "index_comments_on_hospital_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "commercial_backup", force: true do |t|
    t.string   "sex",              limit: 50
    t.string   "demand"
    t.string   "classification"
    t.string   "characteristic"
    t.string   "quota"
    t.string   "company"
    t.integer  "company_id"
    t.string   "age"
    t.string   "name"
    t.string   "insurance_period"
    t.string   "price"
    t.integer  "appointment"
    t.integer  "rebate"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commercial_insurances", force: true do |t|
    t.string   "sex",              limit: 50
    t.string   "demand"
    t.string   "classification"
    t.string   "characteristic"
    t.string   "quota"
    t.string   "company"
    t.integer  "company_id"
    t.string   "age"
    t.string   "name"
    t.string   "insurance_period"
    t.string   "price"
    t.string   "ori_price"
    t.integer  "appointment"
    t.integer  "rebate"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "common_diseases", force: true do |t|
    t.string "name",          limit: 50
    t.string "name_initials", limit: 50
  end

  create_table "confinement_centers", force: true do |t|
    t.integer  "city_id"
    t.integer  "county_id"
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "url"
    t.string   "initial"
    t.string   "price"
    t.decimal  "ori_price",                 precision: 20, scale: 2
    t.string   "image_url"
    t.string   "category"
    t.string   "introduction",  limit: 500
    t.float    "lng",           limit: 53
    t.float    "lat",           limit: 53
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",          limit: 24,                           default: 0.0
    t.integer  "reviews_count",                                      default: 0
    t.integer  "status",                                             default: 1
    t.integer  "click_count",                                        default: 1
  end

  add_index "confinement_centers", ["city_id"], name: "index_confinement_centers_on_city_id", using: :btree
  add_index "confinement_centers", ["reviews_count"], name: "index_confinement_centers_on_reviews_count", using: :btree
  add_index "confinement_centers", ["star"], name: "index_confinement_centers_on_star", using: :btree

  create_table "counties", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["item_id", "item_type"], name: "index_coupons_on_item_id_and_item_type", using: :btree

  create_table "dental_charges", force: true do |t|
    t.integer  "dental_type_id"
    t.string   "name"
    t.string   "pice"
    t.string   "dental_type_name"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dental_onsales", force: true do |t|
    t.integer  "type_id"
    t.integer  "hospital_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "name"
    t.string   "price"
    t.string   "sales"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dental_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disease_commons", force: true do |t|
    t.integer "disease_id"
    t.integer "common_id"
  end

  create_table "disease_details", force: true do |t|
    t.integer "parent_id"
    t.string  "title",     limit: 50
    t.text    "detail"
  end

  create_table "disease_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disease_types", ["parent_id"], name: "index_disease_types_on_parent_id", using: :btree

  create_table "diseases", force: true do |t|
    t.string   "name"
    t.string   "name_initials"
    t.string   "image_url"
    t.text     "etiology"
    t.text     "symptoms"
    t.text     "examination"
    t.text     "treatment"
    t.text     "prevention"
    t.text     "diet"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "disease_type_id"
  end

  add_index "diseases", ["disease_type_id"], name: "index_diseases_on_disease_type_id", using: :btree

  create_table "diseases_doctors", force: true do |t|
    t.integer  "doctor_id",  null: false
    t.integer  "disease_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diseases_doctors", ["disease_id"], name: "index_diseases_doctors_on_disease_id", using: :btree
  add_index "diseases_doctors", ["doctor_id"], name: "index_diseases_doctors_on_doctor_id", using: :btree

  create_table "diseases_drugs", force: true do |t|
    t.integer  "drug_id",    null: false
    t.integer  "disease_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diseases_drugs", ["disease_id"], name: "index_diseases_drugs_on_disease_id", using: :btree
  add_index "diseases_drugs", ["drug_id"], name: "index_diseases_drugs_on_drug_id", using: :btree

  create_table "diseases_hospital_rooms", force: true do |t|
    t.integer  "disease_id"
    t.integer  "hospital_room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_hospitals", id: false, force: true do |t|
    t.integer  "hospital_id", null: false
    t.integer  "disease_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_symptoms", force: true do |t|
    t.integer  "disease_id"
    t.integer  "symptom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_types", force: true do |t|
    t.integer "disease_id"
    t.integer "disease_types_id"
  end

  create_table "doctors", force: true do |t|
    t.string   "name"
    t.string   "name_initials"
    t.integer  "hospital_id"
    t.integer  "hospital_room_id"
    t.string   "position"
    t.string   "nationality"
    t.integer  "is_insurance",       limit: 1
    t.boolean  "is_best_reputation"
    t.string   "hospital_room"
    t.text     "desc"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drugstore_id"
    t.float    "star",               limit: 24, default: 0.0
    t.integer  "reviews_count",                 default: 0
    t.integer  "status",                        default: 1
    t.integer  "click_count",                   default: 1
  end

  add_index "doctors", ["drugstore_id"], name: "index_doctors_on_drugstore_id", using: :btree
  add_index "doctors", ["hospital_id"], name: "index_doctors_on_hospital_id", using: :btree
  add_index "doctors", ["hospital_room_id"], name: "index_doctors_on_hospital_room_id", using: :btree
  add_index "doctors", ["reviews_count"], name: "index_doctors_on_reviews_count", using: :btree
  add_index "doctors", ["star"], name: "index_doctors_on_star", using: :btree

  create_table "down_prices", force: true do |t|
    t.integer  "drug_id"
    t.float    "price",      limit: 24
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "down_prices", ["drug_id"], name: "index_down_prices_on_drug_id", using: :btree

  create_table "drug_details", force: true do |t|
    t.integer "drug_id"
    t.string  "title",   limit: 50
    t.text    "detail"
  end

  add_index "drug_details", ["drug_id"], name: "parent_id", using: :btree

  create_table "drug_manufactory_stores", force: true do |t|
    t.integer "drug_id"
    t.integer "manufactory_id"
    t.integer "drugstore_id"
    t.string  "price",          limit: 50
    t.string  "pinyin",         limit: 50
    t.string  "english_name",   limit: 50
    t.text    "introduction"
  end

  create_table "drug_type", force: true do |t|
    t.string  "name",      limit: 50
    t.integer "parent_id"
    t.integer "typeid"
  end

  create_table "drug_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "disease_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drug_types", ["parent_id"], name: "index_drug_types_on_parent_id", using: :btree

  create_table "drugs", force: true do |t|
    t.string   "name"
    t.string   "manufactory"
    t.decimal  "ori_price",                       precision: 20, scale: 2
    t.decimal  "price",                           precision: 20, scale: 2
    t.decimal  "extension",                       precision: 20, scale: 2
    t.text     "introduction"
    t.integer  "sales_volume",         limit: 8
    t.string   "image_url"
    t.integer  "drug_type_id"
    t.integer  "drug_type_two_id"
    t.string   "brand"
    t.string   "code"
    t.string   "expiry_date"
    t.string   "spec"
    t.string   "dosage"
    t.string   "is_store"
    t.string   "name_initials"
    t.string   "manufactory_initials"
    t.integer  "disease_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_insurance"
    t.integer  "is_otc"
    t.boolean  "is_prescription"
    t.boolean  "is_westren"
    t.boolean  "is_show"
    t.float    "star",                 limit: 24,                          default: 0.0
    t.integer  "reviews_count",                                            default: 0
    t.integer  "editor_id"
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

  create_table "drugs_hospital_rooms", force: true do |t|
    t.integer "drug_id"
    t.integer "hospital_room_id"
  end

  create_table "drugs_types", force: true do |t|
    t.integer "drug_type_id"
    t.integer "drug_id"
  end

  add_index "drugs_types", ["drug_id"], name: "index_drugs_types_on_drug_id", using: :btree
  add_index "drugs_types", ["drug_type_id"], name: "index_drugs_types_on_drug_type_id", using: :btree

  create_table "drugs_users", force: true do |t|
    t.integer  "drug_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugstore_users", force: true do |t|
    t.string   "name"
    t.string   "account"
    t.string   "password"
    t.datetime "first_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "drugstore_users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "drugstore_users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "drugstores", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "image_url"
    t.string   "name_initials"
    t.string   "url"
    t.string   "GSP"
    t.string   "Business_License"
    t.string   "License"
    t.string   "License_Time"
    t.string   "Scope_of_business", limit: 500
    t.integer  "city_id"
    t.integer  "county_id"
    t.boolean  "is_local_hot"
    t.boolean  "is_insurance"
    t.boolean  "is_national_hot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lng",               limit: 53
    t.float    "lat",               limit: 53
    t.decimal  "extension",                     precision: 20, scale: 2
    t.string   "geohash"
    t.float    "star",              limit: 24,                           default: 0.0
    t.integer  "reviews_count",                                          default: 0
    t.integer  "status",                                                 default: 1
    t.integer  "click_count",                                            default: 1
    t.integer  "editor_id"
  end

  add_index "drugstores", ["city_id"], name: "index_drugstores_on_city_id", using: :btree
  add_index "drugstores", ["editor_id"], name: "index_drugstores_on_editor_id", using: :btree
  add_index "drugstores", ["geohash"], name: "index_drugstores_on_geohash", using: :btree
  add_index "drugstores", ["name"], name: "name", using: :btree
  add_index "drugstores", ["reviews_count"], name: "index_drugstores_on_reviews_count", using: :btree
  add_index "drugstores", ["star"], name: "index_drugstores_on_star", using: :btree

  create_table "drugstores_drugs", force: true do |t|
    t.integer "drugstore_id"
    t.integer "drug_id"
  end

  create_table "drugstores_users", force: true do |t|
    t.integer  "drugstore_id"
    t.integer  "user_id"
    t.string   "drug_price",   limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editors", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "telephone"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editors_roles", id: false, force: true do |t|
    t.integer "editor_id"
    t.integer "role_id"
  end

  add_index "editors_roles", ["editor_id", "role_id"], name: "index_editors_roles_on_editor_id_and_role_id", using: :btree

  create_table "eldercares", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "image_url"
    t.integer  "city_id"
    t.boolean  "is_local_hot"
    t.boolean  "is_national_hot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eldercares", ["city_id"], name: "index_eldercares_on_city_id", using: :btree

  create_table "endowment_services", force: true do |t|
    t.integer  "endowment_id", default: 0
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "endowments", force: true do |t|
    t.string "name"
  end

  create_table "examination_charges", force: true do |t|
    t.integer "examination_type_id"
    t.string  "min_price",           limit: 50
    t.string  "max_price",           limit: 50
  end

  create_table "examination_details", force: true do |t|
    t.integer "parent_id"
    t.string  "types",     limit: 50
    t.string  "title",     limit: 500
    t.text    "content"
  end

  create_table "examination_reminds", force: true do |t|
    t.string  "name"
    t.text    "desc"
    t.integer "parent_id"
  end

  create_table "examination_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examination_types", ["parent_id"], name: "index_examination_types_on_parent_id", using: :btree

  create_table "examinations", force: true do |t|
    t.string   "name"
    t.integer  "examination_type_id"
    t.integer  "examination_type_parent_id"
    t.integer  "city_id"
    t.integer  "hospital_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "hospital_name"
    t.string   "applicable"
    t.string   "feature"
    t.string   "image_url"
    t.float    "price",                      limit: 24
    t.float    "save_price",                 limit: 24
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",                       limit: 24, default: 0.0
    t.integer  "reviews_count",                         default: 0
  end

  add_index "examinations", ["city_id"], name: "index_examinations_on_city_id", using: :btree
  add_index "examinations", ["examination_type_id"], name: "index_examinations_on_examination_type_id", using: :btree
  add_index "examinations", ["geohash"], name: "index_examinations_on_geohash", using: :btree
  add_index "examinations", ["reviews_count"], name: "index_examinations_on_reviews_count", using: :btree
  add_index "examinations", ["star"], name: "index_examinations_on_star", using: :btree

  create_table "examinations_hospitals", force: true do |t|
    t.integer "examination_id"
    t.integer "examination_type_id"
    t.integer "examination_type_parent_id"
    t.integer "hospital_id"
  end

  create_table "examinations_new", force: true do |t|
    t.string  "name",                    limit: 50
    t.text    "address"
    t.integer "examination_type_one_id"
    t.integer "examination_type_two_id"
    t.integer "city_id"
    t.integer "hospital_id"
    t.string  "hospital_name",           limit: 50
    t.string  "image_url",               limit: 508
    t.string  "price",                   limit: 508
    t.integer "star"
    t.integer "reviews_count"
  end

  create_table "favorites", force: true do |t|
    t.integer  "account_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["account_id"], name: "index_favorites_on_account_id", using: :btree
  add_index "favorites", ["item_id", "item_type"], name: "index_favorites_on_item_id_and_item_type", using: :btree

  create_table "friendly_link_types", force: true do |t|
    t.string "name"
  end

  create_table "friendly_links", force: true do |t|
    t.string   "title"
    t.integer  "friendly_link_type_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendly_links", ["friendly_link_type_id"], name: "index_friendly_links_on_friendly_link_type_id", using: :btree

  create_table "gynaecology_charges", force: true do |t|
    t.integer  "gynaecology_type_id"
    t.string   "name",                  limit: 50
    t.string   "gynaecology_type_name", limit: 50
    t.string   "pice",                  limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gynaecology_onsales", force: true do |t|
    t.integer  "type_id"
    t.string   "name"
    t.integer  "hospital_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "price"
    t.string   "sales"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gynaecology_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "halls", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.text     "address"
    t.string   "image_url"
    t.float    "lng",        limit: 53
    t.float    "lat",        limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_information_types", force: true do |t|
    t.string   "name",       limit: 50
    t.string   "image_url"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "health_informations", force: true do |t|
    t.integer  "type_id"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.integer  "flag"
    t.text     "content"
    t.float    "star",          limit: 24
    t.integer  "reviews_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_charges", force: true do |t|
    t.integer  "herbalist_doctor_type_id"
    t.string   "name"
    t.string   "pice"
    t.string   "duration"
    t.string   "herbalist_doctor_type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_onsales", force: true do |t|
    t.integer  "hall_id"
    t.integer  "type_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "name"
    t.string   "price"
    t.string   "sales"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbalist_doctor_types", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospital_charges", force: true do |t|
    t.integer  "hospital_type_parent_id"
    t.integer  "hospital_type_id"
    t.string   "name"
    t.string   "project"
    t.string   "price_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_charges", ["hospital_type_id"], name: "hospital_type_id", using: :btree
  add_index "hospital_charges", ["name"], name: "name", using: :btree

  create_table "hospital_doctors", force: true do |t|
    t.integer "hospital_id"
    t.integer "doctor_id"
  end

  create_table "hospital_levels", force: true do |t|
    t.string "name"
  end

  add_index "hospital_levels", ["id"], name: "index_hospital_levels_on_id_and_position", using: :btree

  create_table "hospital_news", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "hospital_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_news", ["hospital_type_id"], name: "index_hospital_type_news_on_hospital_type_id", using: :btree

  create_table "hospital_onsales", force: true do |t|
    t.integer  "hospital_id"
    t.integer  "hospital_charge_id"
    t.integer  "extension"
    t.integer  "appointment"
    t.integer  "rebate"
    t.integer  "sales_volume",       limit: 8
    t.string   "name"
    t.string   "price",              limit: 50
    t.string   "ori_price",          limit: 50
    t.string   "sales"
    t.string   "original_price"
    t.string   "image_url"
    t.string   "discount"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thumb"
    t.float    "star",               limit: 24
    t.integer  "reviews_count"
    t.integer  "click_count"
  end

  create_table "hospital_rooms", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_rooms", ["parent_id"], name: "index_hospital_rooms_on_parent_id", using: :btree

  create_table "hospital_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "filter"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitalinfo", force: true do |t|
    t.string "chengshi"
    t.string "name"
    t.string "dengji"
    t.text   "jianjie"
    t.text   "address"
    t.string "tel"
    t.string "pic",      limit: 500
  end

  create_table "hospitals", force: true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "address"
    t.string   "image_url"
    t.string   "url"
    t.string   "mobile_url"
    t.string   "medical_insurance"
    t.string   "characteristic_departments"
    t.integer  "city_id"
    t.integer  "county_id"
    t.integer  "specialist"
    t.boolean  "is_local_hot"
    t.boolean  "is_national_hot"
    t.boolean  "is_best_reputation"
    t.boolean  "is_best"
    t.decimal  "extension",                             precision: 20, scale: 2
    t.string   "level"
    t.integer  "click_count",                                                    default: 0
    t.float    "lng",                        limit: 53
    t.float    "lat",                        limit: 53
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",                       limit: 24,                          default: 0.0
    t.integer  "reviews_count",                                                  default: 0
    t.float    "equipment_star",             limit: 24,                          default: 0.0
    t.float    "skill_star",                 limit: 24,                          default: 0.0
    t.float    "service_star",               limit: 24,                          default: 0.0
    t.float    "environment_star",           limit: 24,                          default: 0.0
    t.text     "environment_desc"
    t.text     "service_desc"
    t.text     "skill_desc"
    t.text     "equipment_desc"
    t.integer  "hospital_level_id"
    t.string   "name_initials",              limit: 50
    t.string   "bed",                        limit: 50
    t.boolean  "is_foreign"
    t.boolean  "is_community"
    t.boolean  "is_other"
    t.boolean  "is_insurance"
    t.text     "backup"
    t.text     "light"
    t.integer  "status",                                                         default: 1
  end

  add_index "hospitals", ["city_id"], name: "index_hospitals_on_city_id", using: :btree
  add_index "hospitals", ["click_count"], name: "index_hospitals_on_click_count", using: :btree
  add_index "hospitals", ["geohash"], name: "index_hospitals_on_geohash", using: :btree
  add_index "hospitals", ["hospital_level_id"], name: "index_hospitals_on_hospital_level_id", using: :btree
  add_index "hospitals", ["reviews_count"], name: "index_hospitals_on_reviews_count", using: :btree
  add_index "hospitals", ["star"], name: "index_hospitals_on_star", using: :btree

  create_table "hospitals_levels", force: true do |t|
    t.integer  "hospital_id"
    t.integer  "hospital_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals_types", force: true do |t|
    t.integer  "hospital_id"
    t.integer  "hospital_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospitals_types", ["hospital_id"], name: "index_hospitals_types_on_hospital_id", using: :btree
  add_index "hospitals_types", ["hospital_type_id"], name: "index_hospitals_types_on_type_id", using: :btree

  create_table "hospitals_users", force: true do |t|
    t.integer  "hospital_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hot_news", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hot_search_keywords", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information_type", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "informations", force: true do |t|
    t.string   "name"
    t.integer  "information_type_id"
    t.text     "content"
    t.string   "source"
    t.string   "image_url"
    t.string   "created_at",          limit: 50
    t.datetime "updated_at"
    t.float    "star",                limit: 24
    t.integer  "reviews_count"
  end

  create_table "insurance_companies", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "insurance_types", force: true do |t|
    t.string "name"
  end

  create_table "insurances", force: true do |t|
    t.string  "name"
    t.string  "price"
    t.string  "type_name"
    t.string  "url"
    t.integer "appointment"
    t.integer "rebate"
    t.integer "insurance_type_id"
    t.integer "insurance_company_id"
    t.integer "status",               default: 1
  end

  add_index "insurances", ["insurance_company_id"], name: "index_insurances_on_insurance_company_id", using: :btree
  add_index "insurances", ["insurance_type_id"], name: "index_insurances_on_insurance_type_id", using: :btree

  create_table "join_applies", force: true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "email"
    t.string   "contact_user"
    t.string   "contact_phone"
    t.text     "admin_comment"
    t.integer  "status",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "join_applies", ["target_id", "target_type"], name: "index_join_applies_on_target_id_and_target_type", using: :btree

  create_table "manufactories", force: true do |t|
    t.string  "name",                      limit: 50
    t.string  "name_initials",             limit: 50
    t.integer "city_id"
    t.string  "certificate_number",        limit: 50
    t.string  "issuing_date",              limit: 50
    t.string  "validity_period",           limit: 50
    t.string  "legal_representative",      limit: 50
    t.string  "business_owners",           limit: 50
    t.string  "enterprise_type",           limit: 50
    t.text    "address"
    t.text    "production_address"
    t.float   "lng",                       limit: 53
    t.float   "lat",                       limit: 53
    t.text    "production_classification"
    t.string  "url",                       limit: 500
    t.string  "telephone",                 limit: 50
    t.string  "image_url"
    t.integer "status",                                default: 1
  end

  add_index "manufactories", ["name"], name: "name", using: :btree

  create_table "manufactory_drugs", force: true do |t|
    t.integer "manufactory_id"
    t.integer "drug_id"
    t.string  "price_range",    limit: 50
    t.string  "code",           limit: 500
    t.string  "spec",           limit: 50
    t.string  "dosage",         limit: 50
  end

  add_index "manufactory_drugs", ["drug_id"], name: "drug_id", using: :btree
  add_index "manufactory_drugs", ["manufactory_id"], name: "manufactory_id", using: :btree

  create_table "maternal_halls", force: true do |t|
    t.integer  "city_id"
    t.integer  "county_id"
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "image_url"
    t.float    "lng",           limit: 53
    t.float    "lat",           limit: 53
    t.decimal  "ori_price",                precision: 20, scale: 2
    t.string   "geohash"
    t.string   "initial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "star",          limit: 24,                          default: 0.0
    t.integer  "reviews_count",                                     default: 0
    t.integer  "status",                                            default: 1
    t.integer  "click_count",                                       default: 1
  end

  add_index "maternal_halls", ["city_id"], name: "index_maternal_halls_on_city_id", using: :btree
  add_index "maternal_halls", ["reviews_count"], name: "index_maternal_halls_on_reviews_count", using: :btree
  add_index "maternal_halls", ["star"], name: "index_maternal_halls_on_star", using: :btree

  create_table "medical_articles", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "click_count"
    t.datetime "posted_date"
    t.text     "content"
    t.string   "author"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_institutions", force: true do |t|
    t.string  "name",        limit: 50
    t.integer "hospital_id"
  end

  create_table "medical_posts", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "click_count"
    t.datetime "posted_date"
    t.text     "content"
    t.string   "author"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_tips", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "click_count"
    t.datetime "posted_date"
    t.text     "content"
    t.string   "author"
    t.string   "website"
    t.integer  "hospital_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_tips", ["hospital_type_id"], name: "index_medical_tips_on_hospital_type_id", using: :btree

  create_table "menus", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "seq"
    t.string   "icon"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["parent_id"], name: "index_menus_on_parent_id", using: :btree

  create_table "net_infos", force: true do |t|
    t.string   "title"
    t.string   "image_url"
    t.datetime "created_at"
    t.integer  "hospital_type_id"
  end

  add_index "net_infos", ["hospital_type_id"], name: "index_net_infos_on_hospital_type_id", using: :btree

  create_table "nursing_rooms", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "image_url"
    t.integer  "city_id"
    t.integer  "county_id"
    t.string   "geohash"
    t.string   "initial"
    t.string   "bed"
    t.string   "target",        limit: 5000
    t.string   "price",         limit: 500
    t.string   "ori_price",     limit: 500
    t.string   "light",         limit: 5000
    t.string   "nature",        limit: 500
    t.string   "mold",          limit: 500
    t.string   "url",           limit: 500
    t.text     "service"
    t.text     "traffic"
    t.text     "introduction"
    t.float    "lat",           limit: 53
    t.float    "lng",           limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "back_up",       limit: 50
    t.float    "star",          limit: 24,   default: 0.0
    t.integer  "reviews_count",              default: 0
    t.integer  "status",                     default: 1
    t.integer  "click_count",                default: 1
  end

  add_index "nursing_rooms", ["city_id"], name: "index_nursing_rooms_on_city_id", using: :btree
  add_index "nursing_rooms", ["geohash"], name: "index_nursing_rooms_on_geohash", using: :btree
  add_index "nursing_rooms", ["reviews_count"], name: "index_nursing_rooms_on_reviews_count", using: :btree
  add_index "nursing_rooms", ["star"], name: "index_nursing_rooms_on_star", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "quantity"
    t.float    "price",             limit: 24
    t.float    "discount",          limit: 24
    t.string   "trade_no"
    t.string   "provider"
    t.string   "state"
    t.string   "logistics_type"
    t.string   "logistics_name"
    t.float    "logistics_fee",     limit: 24
    t.string   "logistics_payment"
    t.string   "transport_type"
    t.string   "receive_name"
    t.text     "receive_address"
    t.string   "receive_zip"
    t.string   "receive_mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "name"
  end

  add_index "orders", ["account_id"], name: "index_orders_on_account_id", using: :btree
  add_index "orders", ["item_type", "item_id"], name: "index_orders_on_item_type_and_item_id", using: :btree

  create_table "parts", force: true do |t|
    t.string "name", limit: 50, default: "0", null: false
  end

  create_table "photos", force: true do |t|
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree

  create_table "polyclinic_charges", force: true do |t|
    t.integer  "province_id"
    t.string   "name",        limit: 50
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_notifications", force: true do |t|
    t.integer  "account_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.float    "price",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "price_notifications", ["account_id"], name: "index_price_notifications_on_account_id", using: :btree
  add_index "price_notifications", ["item_id", "item_type"], name: "index_price_notifications_on_item_id_and_item_type", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  create_table "raider_details", force: true do |t|
    t.integer "parent_id"
    t.string  "name",      limit: 50
    t.text    "details"
  end

  create_table "raiders", force: true do |t|
    t.string "name"
    t.text   "detail"
  end

  create_table "reviews", force: true do |t|
    t.integer  "account_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "order_id"
    t.integer  "star"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment"
    t.integer  "service"
    t.integer  "charge"
    t.integer  "technique"
  end

  add_index "reviews", ["account_id"], name: "index_reviews_on_account_id", using: :btree
  add_index "reviews", ["item_id", "item_type"], name: "index_reviews_on_item_id_and_item_type", using: :btree
  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "shaping_items", force: true do |t|
    t.string   "name"
    t.string   "price_scope"
    t.string   "target"
    t.string   "operation_time"
    t.string   "note"
    t.string   "life_note"
    t.string   "remark"
    t.string   "shaping_type_name"
    t.integer  "shaping_type_id"
    t.string   "image_url"
    t.float    "star",              limit: 24, default: 5.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviews_count",                default: 0
  end

  add_index "shaping_items", ["reviews_count"], name: "index_shaping_items_on_reviews_count", using: :btree
  add_index "shaping_items", ["shaping_type_id"], name: "index_shaping_items_on_shaping_type_id", using: :btree
  add_index "shaping_items", ["star"], name: "index_shaping_items_on_star", using: :btree

  create_table "shaping_onsales", force: true do |t|
    t.integer  "type_id"
    t.integer  "hospital_id"
    t.integer  "appointment"
    t.integer  "rebate"
    t.string   "name"
    t.string   "price"
    t.string   "sales"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shaping_types", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "desc"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shaping_types", ["parent_id"], name: "index_shaping_types_on_parent_id", using: :btree

  create_table "social_securities", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "province_id"
    t.integer  "social_security_type_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_securities", ["city_id"], name: "index_social_securities_on_city_id", using: :btree
  add_index "social_securities", ["province_id"], name: "index_social_securities_on_province_id", using: :btree

  create_table "social_security_types", force: true do |t|
    t.string "name"
  end

  create_table "stat_daily_ips", force: true do |t|
    t.string   "ip"
    t.integer  "count"
    t.integer  "city_id"
    t.date     "occur_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stat_daily_ips", ["city_id"], name: "index_stat_daily_ips_on_city_id", using: :btree

  create_table "symptom_details", force: true do |t|
    t.string "title"
    t.string "detail_id"
    t.text   "detail"
    t.string "image_url"
  end

  create_table "symptoms", force: true do |t|
    t.string   "name"
    t.string   "name_initials"
    t.integer  "part_id"
    t.string   "xgjc"
    t.string   "detail_id"
    t.string   "xgzz"
    t.string   "xgyp"
    t.string   "xgjb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp", id: false, force: true do |t|
    t.integer "id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "account"
    t.string   "password"
    t.datetime "first_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
