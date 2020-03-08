# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_08_152312) do

  create_table "trends", force: :cascade do |t|
    t.date "result_date"
    t.string "name"
    t.text "url"
    t.integer "tweet_volume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_summaries", force: :cascade do |t|
    t.date "result_date"
    t.integer "friends_count"
    t.integer "followers_count"
    t.integer "statuses_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "screen_name"
    t.integer "statuses_count", default: 0
    t.integer "friends_count", default: 0
    t.integer "followers_count", default: 0
    t.integer "listed_count", default: 0
    t.integer "favourites_count", default: 0
    t.boolean "is_follower", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
