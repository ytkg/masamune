class AdminUser < ApplicationRecord
  has_many :friends
  has_many :friend_users, through: :friends, source: :twitter_user
  has_many :followers
  has_many :follower_users, through: :followers, source: :twitter_user
  has_many :follows
  has_many :follow_users, through: :follows, source: :twitter_user
  has_many :tweets
  has_many :summaries
  has_many :points
  has_one :detail

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

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_API_CONSUMER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end
end
