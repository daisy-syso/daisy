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

ActiveRecord::Schema.define(version: 20140814094251) do

  create_table "cities", force: true do |t|
    t.integer "index"
    t.integer "province_id"
    t.string  "name"
  end

  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree

  create_table "doctors", force: true do |t|
    t.string   "name"
    t.integer  "hospital_id"
    t.integer  "hospital_room_id"
    t.string   "position"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doctors", ["hospital_id"], name: "index_doctors_on_hospital_id", using: :btree
  add_index "doctors", ["hospital_room_id"], name: "index_doctors_on_hospital_room_id", using: :btree

  create_table "drug_types", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "drugs", force: true do |t|
    t.string  "name"
    t.string  "manufactory"
    t.decimal "ori_price",    precision: 10, scale: 0
    t.decimal "sale_price",   precision: 10, scale: 0
    t.text    "introduction"
    t.string  "image_url"
    t.integer "drug_type_id"
    t.string  "brand"
    t.string  "code"
    t.string  "expiry_date"
    t.string  "spec"
  end

  create_table "drugs_types", force: true do |t|
    t.integer "drug_type_id"
    t.integer "drug_id"
  end

  add_index "drugs_types", ["drug_id"], name: "index_drugs_types_on_drug_id", using: :btree
  add_index "drugs_types", ["drug_type_id"], name: "index_drugs_types_on_drug_type_id", using: :btree

  create_table "drugstores", force: true do |t|
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

  add_index "drugstores", ["city_id"], name: "index_drugstores_on_city_id", using: :btree

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

  create_table "examination_types", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  add_index "examination_types", ["parent_id"], name: "index_examination_types_on_parent_id", using: :btree

  create_table "examinations", force: true do |t|
    t.string  "name"
    t.integer "examination_type_id"
    t.integer "city_id"
    t.string  "hospital_name"
    t.string  "applicable"
    t.string  "feature"
    t.float   "price",               limit: 24
    t.float   "save_price",          limit: 24
  end

  add_index "examinations", ["city_id"], name: "index_examinations_on_city_id", using: :btree
  add_index "examinations", ["examination_type_id"], name: "index_examinations_on_examination_type_id", using: :btree

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

  create_table "hospital_rooms", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_rooms", ["parent_id"], name: "index_hospital_rooms_on_parent_id", using: :btree

  create_table "hospital_type_news", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "hospital_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hospital_type_news", ["hospital_type_id"], name: "index_hospital_type_news_on_hospital_type_id", using: :btree

  create_table "hospital_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hospitals", force: true do |t|
    t.string  "name"
    t.string  "telephone"
    t.string  "address"
    t.string  "image_url"
    t.string  "url"
    t.integer "city_id"
    t.boolean "is_local_hot"
    t.boolean "is_national_hot"
    t.boolean "is_best_reputation"
    t.string  "level"
  end

  add_index "hospitals", ["city_id"], name: "index_hospitals_on_city_id", using: :btree

  create_table "hospitals_types", force: true do |t|
    t.integer "hospital_id"
    t.integer "type_id"
  end

  add_index "hospitals_types", ["hospital_id"], name: "index_hospitals_types_on_hospital_id", using: :btree
  add_index "hospitals_types", ["type_id"], name: "index_hospitals_types_on_type_id", using: :btree

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

  create_table "insurance_categories", force: true do |t|
    t.string "name"
  end

  create_table "insurance_companies", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "insurances", force: true do |t|
    t.string  "name"
    t.string  "url"
    t.integer "insurance_category_id"
    t.integer "insurance_company_id"
  end

  add_index "insurances", ["insurance_category_id"], name: "index_insurances_on_insurance_category_id", using: :btree
  add_index "insurances", ["insurance_company_id"], name: "index_insurances_on_insurance_company_id", using: :btree

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
    t.string  "name"
    t.string  "address"
    t.string  "telephone"
    t.string  "image_url"
    t.integer "city_id"
  end

  add_index "nursing_rooms", ["city_id"], name: "index_nursing_rooms_on_city_id", using: :btree

  create_table "provinces", force: true do |t|
    t.string "name"
  end

  create_table "shaping_items", force: true do |t|
    t.string  "name"
    t.string  "price_scope"
    t.string  "target"
    t.string  "operation_time"
    t.string  "note"
    t.string  "life_note"
    t.string  "remark"
    t.integer "shaping_type_id"
    t.string  "image_url"
  end

  add_index "shaping_items", ["shaping_type_id"], name: "index_shaping_items_on_shaping_type_id", using: :btree

  create_table "shaping_types", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.string  "desc"
    t.string  "image_url"
  end

  add_index "shaping_types", ["parent_id"], name: "index_shaping_types_on_parent_id", using: :btree

  create_table "social_securities", force: true do |t|
    t.integer "city_id"
    t.string  "url"
  end

  add_index "social_securities", ["city_id"], name: "index_social_securities_on_city_id", using: :btree

  create_table "social_security_drugstores", force: true do |t|
    t.integer "city_id"
    t.string  "url"
  end

  add_index "social_security_drugstores", ["city_id"], name: "index_social_security_drugstores_on_city_id", using: :btree

  create_table "social_security_hospitals", force: true do |t|
    t.integer "city_id"
    t.string  "url"
  end

  add_index "social_security_hospitals", ["city_id"], name: "index_social_security_hospitals_on_city_id", using: :btree

  create_table "stat_daily_ips", force: true do |t|
    t.string   "ip"
    t.integer  "count"
    t.integer  "city_id"
    t.date     "occur_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stat_daily_ips", ["city_id"], name: "index_stat_daily_ips_on_city_id", using: :btree

  create_table "temps", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
