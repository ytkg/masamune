namespace :user do
  task follow: :environment do
    followed_users_count = FollowedUser.where('created_at >= ?', 3.hour.ago).count
    exit if rand(1..followed_users_count) != 1

    friend_ids = TwitterApiService.fetch_friend_ids
    friend_ids.each do |friend_id|
      FollowedUser.find_or_create_by(twitter_id: friend_id)
    end

    twitter_ids = FollowedUser.pluck(:twitter_id)
    count = 0
    users = TwitterApiService.fetch_users_by_keyword_search('#プロスピA')
    users.each do |user|
      next if twitter_ids.include?(user.id)
      next if user.friends_count < 50
      next if user.followers_count < 50
      next if user.description.exclude?('プロスピ')

      Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping("screen_name: #{user.screen_name}, friends_count: #{user.friends_count}, followers_count: #{user.followers_count}")
      count += 1

      break if count == 12
    end

    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping("#{count}人を擬似フォローしました")
  rescue => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
