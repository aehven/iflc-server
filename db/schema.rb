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

ActiveRecord::Schema.define(version: 20170505123131) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "phone"
    t.string  "fax"
    t.string  "email"
    t.string  "website"
    t.string  "street"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "kind"
    t.string  "om"
    t.string  "fd1"
    t.string  "fd2"
    t.string  "rc"
    t.integer "referrer"
  end

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.datetime "date"
    t.text     "text",       limit: 65535
    t.index ["account_id"], name: "index_activities_on_account_id", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "account_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "phone"
    t.string  "email"
    t.string  "street"
    t.string  "city"
    t.string  "zip"
    t.integer "kind"
    t.string  "state"
    t.string  "ma"
    t.boolean "sunday"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.string  "cellphone"
    t.index ["account_id"], name: "index_contacts_on_account_id", using: :btree
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.string  "favoritable_type"
    t.integer "favoritable_id"
    t.index ["favoritable_id", "favoritable_type", "user_id"], name: "unique_favorites", unique: true, using: :btree
    t.index ["favoritable_id"], name: "index_favorites_on_favoritable_id", using: :btree
    t.index ["favoritable_type"], name: "index_favorites_on_favoritable_type", using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider",                             default: "email", null: false
    t.string   "uid",                                  default: "",      null: false
    t.string   "encrypted_password",                   default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role",                                 default: 1000
    t.string   "phone"
    t.string   "address"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "activities", "accounts"
  add_foreign_key "contacts", "accounts"
  add_foreign_key "favorites", "users"
end
