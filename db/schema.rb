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

ActiveRecord::Schema.define(:version => 20130815112154) do

  create_table "ads", :force => true do |t|
    t.integer  "advertizer_id"
    t.integer  "hop_id"
    t.string   "ad_type"
    t.integer  "price"
    t.integer  "amt_paid"
    t.string   "link"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_key"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "asks", :force => true do |t|
    t.string   "ask"
    t.text     "answer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.text     "text"
    t.datetime "created_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "email_alerts", :force => true do |t|
    t.text     "text"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "schedule_date"
    t.string   "subject"
    t.integer  "template_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "faqs", :force => true do |t|
    t.string   "ask"
    t.text     "answer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "accepted_at"
  end

  create_table "hop_tasks", :force => true do |t|
    t.integer  "hop_id"
    t.text     "text"
    t.integer  "sponsor_id"
    t.string   "price"
    t.integer  "pts"
    t.integer  "bonus"
    t.integer  "amt_paid"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "hop_tasks", ["hop_id"], :name => "index_hop_tasks_on_hop_id"

  create_table "hoppers_hops", :force => true do |t|
    t.integer "user_id"
    t.integer "hop_id"
    t.integer "pts"
  end

  create_table "hops", :force => true do |t|
    t.string   "name"
    t.datetime "time_start"
    t.datetime "time_end"
    t.integer  "producer_id"
    t.string   "code"
    t.string   "price"
    t.integer  "jackpot"
    t.boolean  "daily"
    t.boolean  "close"
    t.string   "event"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "target_object_id"
    t.string   "target_object"
    t.datetime "created_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "text"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "schedule_date"
    t.boolean  "synchronized"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "event_type"
    t.integer  "comment_id"
    t.integer  "like_id"
    t.integer  "prize_id"
    t.integer  "friend_id"
    t.datetime "created_at"
  end

  create_table "prizes", :force => true do |t|
    t.string  "cost"
    t.integer "place"
    t.integer "user_id"
    t.integer "hop_id"
    t.integer "pts"
    t.string  "prize_type"
  end

  add_index "prizes", ["hop_id"], :name => "index_prizes_on_hop_id"
  add_index "prizes", ["user_id"], :name => "index_prizes_on_user_id"

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

  create_table "user_hop_tasks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "hop_task_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "comment"
    t.boolean  "facebook_shared"
    t.boolean  "twitter_shared"
    t.boolean  "google_shared"
  end

  add_index "user_hop_tasks", ["hop_task_id"], :name => "index_user_hop_tasks_on_hop_task_id"
  add_index "user_hop_tasks", ["user_id"], :name => "index_user_hop_tasks_on_user_id"

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
    t.string   "zip"
    t.string   "user_name"
    t.string   "contact"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "bio"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "google"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
