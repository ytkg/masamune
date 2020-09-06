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

ActiveRecord::Schema.define(version: 2020_09_06_151722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "screen_name", null: false
    t.string "name", null: false
    t.string "image_url", null: false
    t.string "token", null: false
    t.string "secret", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "details", force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_details_on_admin_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.bigint "twitter_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_followers_on_admin_user_id"
    t.index ["twitter_user_id"], name: "index_followers_on_twitter_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.bigint "twitter_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_follows_on_admin_user_id"
    t.index ["twitter_user_id"], name: "index_follows_on_twitter_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.bigint "twitter_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_friends_on_admin_user_id"
    t.index ["twitter_user_id"], name: "index_friends_on_twitter_user_id"
  end

  create_table "summaries", force: :cascade do |t|
    t.bigint "admin_user_id", null: false
    t.date "result_date"
    t.integer "friends_count"
    t.integer "followers_count"
    t.integer "statuses_count"
    t.integer "retweet_count"
    t.integer "favorite_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_user_id"], name: "index_summaries_on_admin_user_id"
  end

  create_table "tweets", id: :bigint, default: nil, force: :cascade do |t|
    t.datetime "tweeted_at"
    t.text "text"
    t.integer "retweet_count", default: 0
    t.integer "favorite_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "admin_user_id"
    t.index ["admin_user_id"], name: "index_tweets_on_admin_user_id"
  end

  create_table "twitter_users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "screen_name"
    t.string "name"
    t.integer "statuses_count", default: 0
    t.integer "friends_count", default: 0
    t.integer "followers_count", default: 0
    t.integer "listed_count", default: 0
    t.integer "favourites_count", default: 0
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
    t.integer "retweet_count"
    t.integer "favorite_count"
    t.string "name"
    t.string "screen_name"
    t.text "profile_image_url_https"
  end

  create_table "users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "screen_name"
    t.integer "statuses_count", default: 0
    t.integer "friends_count", default: 0
    t.integer "followers_count", default: 0
    t.integer "listed_count", default: 0
    t.integer "favourites_count", default: 0
    t.boolean "is_follower", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_friend", default: false
    t.boolean "followed", default: false
  end

  add_foreign_key "details", "admin_users"
  add_foreign_key "followers", "admin_users"
  add_foreign_key "followers", "twitter_users"
  add_foreign_key "follows", "admin_users"
  add_foreign_key "follows", "twitter_users"
  add_foreign_key "friends", "admin_users"
  add_foreign_key "friends", "twitter_users"
  add_foreign_key "summaries", "admin_users"
  add_foreign_key "tweets", "admin_users"
end
