# frozen_string_literal: true

class AdminUser < ApplicationRecord
  has_many :friends, dependent: :destroy
  has_many :friend_users, through: :friends, source: :twitter_user
  has_many :followers, dependent: :destroy
  has_many :follower_users, through: :followers, source: :twitter_user
  has_many :follows, dependent: :destroy
  has_many :follow_users, through: :follows, source: :twitter_user
  has_many :tweets, dependent: :destroy
  has_many :summaries, dependent: :destroy
  has_many :points, dependent: :destroy
  has_one :detail, dependent: :destroy

  def self.create_or_update_from_auth(auth)
    find_or_initialize_by(id: auth[:uid]).tap do |user|
      user.update!(
        screen_name: auth[:info][:nickname],
        name: auth[:info][:name],
        image_url: auth[:info][:image],
        token: auth[:credentials][:token],
        secret: auth[:credentials][:secret]
      )
    end
  end

  delegate :count, to: :friends, prefix: true

  delegate :count, to: :followers, prefix: true

  def friends_and_followers_count
    friends.where(twitter_user_id: followers.select(:twitter_user_id)).count
  end

  def friends_except_followers_count
    friends.where.not(twitter_user_id: followers.select(:twitter_user_id)).count
  end

  def followers_except_friends_count
    followers.where.not(twitter_user_id: friends.select(:twitter_user_id)).count
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_API_CONSUMER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
