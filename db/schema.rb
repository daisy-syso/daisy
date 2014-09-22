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

ActiveRecord::Schema.define(version: 20140922015251) do

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

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "cities", force: true do |t|
    t.integer "index"
    t.integer "province_id"
    t.string  "name"
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

  create_table "confinement_centers", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.string   "url"
    t.float    "lng",        limit: 53
    t.float    "lat",        limit: 53
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "confinement_centers", ["city_id"], name: "index_confinement_centers_on_city_id", using: :btree

  create_table "coupons", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["item_id", "item_type"], name: "index_coupons_on_item_id_and_item_type", using: :btree

  create_table "disease_types", force: true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  add_index "disease_types", ["parent_id"], name: "index_disease_types_on_parent_id", using: :btree

  create_table "diseases", force: true do |t|
    t.string   "name"
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

  create_table "diseases_doctors", id: false, force: true do |t|
    t.integer "doctor_id",  null: false
    t.integer "disease_id", null: false
  end

  create_table "diseases_drugs", force: true do |t|
    t.integer  "drug_id",    default: 0
    t.integer  "disease_id", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diseases_hospitals", id: false, force: true do |t|
    t.integer "hospital_id", null: false
    t.integer "disease_id",  null: false
  end

  create_table "doctors", force: true do |t|
    t.string   "name"
    t.integer  "hospital_id"
    t.integer  "hospital_room_id"
    t.string   "position"
    t.string   "hospital_room"
    t.text     "desc"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "drugstore_id"
  end

  add_index "doctors", ["drugstore_id"], name: "index_doctors_on_drugstore_id", using: :btree
  add_index "doctors", ["hospital_id"], name: "index_doctors_on_hospital_id", using: :btree
  add_index "doctors", ["hospital_room_id"], name: "index_doctors_on_hospital_room_id", using: :btree

  create_table "down_prices", force: true do |t|
    t.integer  "drug_id"
    t.float    "price",      limit: 24
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "down_prices", ["drug_id"], name: "index_down_prices_on_drug_id", using: :btree

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
    t.integer "disease_id"
  end

  add_index "drugs", ["disease_id"], name: "index_drugs_on_disease_id", using: :btree

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
    t.float    "lng",             limit: 53
    t.float    "lat",             limit: 53
    t.string   "geohash"
  end

  add_index "drugstores", ["city_id"], name: "index_drugstores_on_city_id", using: :btree
  add_index "drugstores", ["geohash"], name: "index_drugstores_on_geohash", using: :btree

  create_table "drugstores_users", force: true do |t|
    t.integer  "drugstore_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string  "geohash"
  end

  add_index "examinations", ["city_id"], name: "index_examinations_on_city_id", using: :btree
  add_index "examinations", ["examination_type_id"], name: "index_examinations_on_examination_type_id", using: :btree
  add_index "examinations", ["geohash"], name: "index_examinations_on_geohash", using: :btree

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
    t.integer "click_count",                   default: 0
    t.float   "lng",                limit: 53
    t.float   "lat",                limit: 53
    t.string  "geohash"
  end

  add_index "hospitals", ["city_id"], name: "index_hospitals_on_city_id", using: :btree
  add_index "hospitals", ["click_count"], name: "index_hospitals_on_click_count", using: :btree
  add_index "hospitals", ["geohash"], name: "index_hospitals_on_geohash", using: :btree

  create_table "hospitals_types", force: true do |t|
    t.integer "hospital_id"
    t.integer "type_id"
  end

  add_index "hospitals_types", ["hospital_id"], name: "index_hospitals_types_on_hospital_id", using: :btree
  add_index "hospitals_types", ["type_id"], name: "index_hospitals_types_on_type_id", using: :btree

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

  create_table "maternal_halls", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.float    "lng",        limit: 53
    t.float    "lat",        limit: 53
    t.string   "geohash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maternal_halls", ["city_id"], name: "index_maternal_halls_on_city_id", using: :btree

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
    t.string  "geohash"
    t.float   "lat",       limit: 53
    t.float   "lng",       limit: 53
  end

  add_index "nursing_rooms", ["city_id"], name: "index_nursing_rooms_on_city_id", using: :btree
  add_index "nursing_rooms", ["geohash"], name: "index_nursing_rooms_on_geohash", using: :btree

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

  create_table "photos", force: true do |t|
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "photos", ["category_id"], name: "index_photos_on_category_id", using: :btree

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
    t.string "name"
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
  end

  add_index "reviews", ["account_id"], name: "index_reviews_on_account_id", using: :btree
  add_index "reviews", ["item_id", "item_type"], name: "index_reviews_on_item_id_and_item_type", using: :btree
  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id", using: :btree

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
