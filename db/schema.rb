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

ActiveRecord::Schema.define(version: 20170306030317) do

  create_table "users", id: :bigint, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC" do |t|
    t.string "username", limit: 30, null: false, collation: "ascii_bin"
    t.string "email", null: false, collation: "ascii_bin"
    t.string "name", limit: 100
    t.text "bio"
    t.string "magic_link_token", limit: 50
    t.datetime "magic_link_expires_at"
    t.datetime "magic_link_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "idx_email", unique: true
    t.index ["magic_link_token"], name: "idx_magic_link_token", unique: true
    t.index ["username"], name: "idx_username", unique: true
  end

end
