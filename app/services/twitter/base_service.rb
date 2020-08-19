module Twitter
  class BaseService
    private_class_method def self.client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_API_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_API_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_API_ACCESS_TOKEN_SECRET']
      end
    end
  end
end
