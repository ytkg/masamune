namespace :user do
  task follow: :environment do
    exit if rand(1..12) != 1

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_API_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_API_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_API_ACCESS_TOKEN_SECRET']
    end

    friend_ids = client.friend_ids.take(10000)
    friend_ids.each do |friend_id|
      FollowedUser.find_or_create_by(twitter_id: friend_id)
    end

    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(FollowedUser.count)
  rescue => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
