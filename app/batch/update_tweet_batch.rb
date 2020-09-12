# frozen_string_literal: true

class UpdateTweetBatch
  def initialize(admin_user)
    @admin_user = admin_user
    @client = admin_user.client
  end

  def execute
    tweets = Twitter::FetchTweetsService.call(@client)
    tweets.each do |tweet|
      next if tweet.text.match(/^RT @/)

      @admin_user.tweets.update_or_create(tweet)
    end
  end
end
