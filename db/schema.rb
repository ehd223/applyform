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

ActiveRecord::Schema.define(version: 20180108124506) do

  create_table "Test", force: :cascade do |t|
    t.string "학번"
    t.string "전화번호"
    t.string "이메일"
    t.string "기타"
    t.string "등등"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "Test2", force: :cascade do |t|
    t.string "이름"
    t.string "학번"
    t.string "학년"
    t.string "전화번호"
    t.string "이메일"
    t.string "12"
    t.string "23"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "Test3", force: :cascade do |t|
    t.string "이름"
    t.string "학번"
    t.string "학년"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.date "start"
    t.date "end"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unst", force: :cascade do |t|
    t.string "이름"
    t.string "학번"
    t.string "학년"
    t.string "5"
    t.string "6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "마지막", force: :cascade do |t|
    t.string "이름"
    t.string "학번"
    t.string "학년"
    t.string "전화번호"
    t.string "기타"
    t.string "등등"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "새로", force: :cascade do |t|
    t.string "이름"
    t.string "학번"
    t.string "학년"
    t.string "전화번호"
    t.string "이메일"
    t.string "추가"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
