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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130708103007) do

  create_table "ads", :force => true do |t|
    t.string   "ad_name"
    t.string   "contact"
    t.string   "email"
    t.string   "phone"
    t.string   "price"
    t.string   "ad_type"
    t.string   "link_to_ad"
    t.integer  "hop_id"
    t.integer  "sponsor_id"
    t.string   "hop_ad_picture_file_name"
    t.string   "hop_ad_picture_content_type"
    t.integer  "hop_ad_picture_file_size"
    t.datetime "hop_ad_picture_updated_at"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "amt"
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_key"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "daily_hops", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.text     "text_for_item"
    t.string   "winner"
    t.string   "points"
    t.string   "share_point"
    t.string   "jackpot"
    t.string   "users"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "hop_tasks", :force => true do |t|
    t.integer  "hop_id"
    t.text     "text_for_hop"
    t.integer  "sponsor_id"
    t.string   "hop_task_price"
    t.string   "sponsor_name"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "hop_picture_file_name"
    t.string   "hop_picture_content_type"
    t.integer  "hop_picture_file_size"
    t.datetime "hop_picture_updated_at"
    t.integer  "pts"
    t.integer  "bonus"
    t.integer  "amt"
  end

  add_index "hop_tasks", ["hop_id"], :name => "index_hop_tasks_on_hop_id"

  create_table "hops", :force => true do |t|
    t.string   "name"
    t.string   "time_start"
    t.string   "time_end"
    t.integer  "producer_id"
    t.string   "producer_contact"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "hop_code"
    t.string   "hop_price"
    t.string   "jackpot"
    t.string   "hop_items"
    t.boolean  "daily_hop",        :default => false
    t.boolean  "close",            :default => false
    t.string   "event"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "zip"
    t.string   "user_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
