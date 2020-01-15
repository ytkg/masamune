class TwitterApiService
  class << self
    def fetch_user
      client.user(1216390208209293313)
    end

    def fetch_trends
      client.trends(23424856).attrs[:trends]
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
