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

ActiveRecord::Schema.define(version: 20140731072709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: true do |t|
    t.integer  "novel_id",                       null: false
    t.string   "title",      default: "notitle"
    t.string   "comment",    default: ""
    t.integer  "serial",     default: 0
    t.integer  "time",       default: 0
    t.integer  "episode",    default: 0
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "novels", force: true do |t|
    t.string   "title",      default: "notitle"
    t.text     "summary",    default: ""
    t.string   "comment",    default: ""
    t.integer  "mode",       default: 0
    t.integer  "time",       default: 0
    t.integer  "episode",    default: 0
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", force: true do |t|
    t.integer  "chapter_id",                     null: false
    t.string   "title",      default: "notitle"
    t.string   "comment",    default: ""
    t.integer  "serial",     default: 0
    t.integer  "time",       default: 0
    t.integer  "episode",    default: 0
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.integer  "volume_id",                      null: false
    t.string   "title",      default: "notitle"
    t.string   "comment",    default: ""
    t.string   "contents"
    t.integer  "serial",     default: 0
    t.integer  "time",       default: 0
    t.boolean  "is_scene",   default: false
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volumes", force: true do |t|
    t.integer  "part_id",                        null: false
    t.string   "title",      default: "notitle"
    t.string   "comment",    default: ""
    t.integer  "serial",     default: 0
    t.integer  "time",       default: 0
    t.integer  "episode",    default: 0
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
