# frozen_string_literal: true

class TwitterApiService
  class << self
    def fetch_user
      client.user
    end

    def fetch_users(ids)
      client.users(ids)
    end

    def fetch_tweets
      client.user_timeline(count: 200)
    end

    def fetch_users_by_keyword_search(keyword)
      client.search(keyword).take(3000).map(&:user).uniq
    end

    def fetch_friend_ids
      client.friend_ids.take(10000)
    end

    def fetch_follower_ids
      client.follower_ids.take(10000)
    end

    def follow(user)
      client.follow(user)
    end

    def unfollow(user)
      client.unfollow(user)
    end

    private

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_API_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_API_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_API_ACCESS_TOKEN_SECRET']
      end
    end
  end
end
