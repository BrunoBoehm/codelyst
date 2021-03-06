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

ActiveRecord::Schema.define(version: 20161223192348) do

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "version_id"
    t.integer  "order"
    t.text     "code"
    t.text     "notes"
    t.string   "language"
    t.string   "path"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.text     "description"
    t.string   "picture_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "list_id"
    t.integer  "user_id"
    t.integer  "downvotes"
    t.integer  "upvotes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
