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

ActiveRecord::Schema.define(version: 20170318212246) do

  create_table "articles", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.bigint "user_id", null: false, unsigned: true
    t.text "body", null: false
    t.date "published_on", null: false
    t.datetime "edited_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edited_at"], name: "idx_edited_at"
    t.index ["user_id", "published_on"], name: "idx_uid_and_published_on", unique: true
  end

  create_table "invitations", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "email", null: false, collation: "ascii_bin"
    t.datetime "sent_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "idx_email", unique: true
  end

  create_table "users", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "username", limit: 30, null: false, collation: "ascii_bin"
    t.string "email", null: false, collation: "ascii_bin"
    t.string "name", limit: 100
    t.text "bio"
    t.string "time_zone", limit: 30, default: "UTC", null: false
    t.datetime "magic_link_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "idx_email", unique: true
    t.index ["username"], name: "idx_username", unique: true
  end

end
