namespace :user do
  task follow: :environment do
    exit if rand(1..12) != 1

    friend_ids = TwitterApiService.fetch_friend_ids
    friend_ids.each do |friend_id|
      FollowedUser.find_or_create_by(twitter_id: friend_id)
    end

    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(FollowedUser.count)
  rescue => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
