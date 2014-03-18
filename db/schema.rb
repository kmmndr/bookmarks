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

ActiveRecord::Schema.define(version: 20140318125412) do

  create_table "bookmarks", force: true do |t|
    t.string   "title"
    t.string   "href"
    t.datetime "visited_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folder_id"
    t.integer  "user_id"
  end

  add_index "bookmarks", ["folder_id"], name: "index_bookmarks_on_folder_id"
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id"

  create_table "folders", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_folder_id"
    t.integer  "user_id"
  end

  add_index "folders", ["parent_folder_id"], name: "index_folders_on_parent_folder_id"
  add_index "folders", ["user_id"], name: "index_folders_on_user_id"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
