# frozen_string_literal: true

namespace :user do
  task follow: :environment do
    friend_ids = TwitterApiService.fetch_friend_ids
    twitter_users = TwitterApiService.fetch_users(friend_ids)
    twitter_users.each do |twitter_user|
      user = User.find_or_initialize_by(id: twitter_user.id)
      user.update(
        screen_name: twitter_user.screen_name,
        statuses_count: twitter_user.statuses_count,
        friends_count: twitter_user.friends_count,
        followers_count: twitter_user.followers_count,
        listed_count: twitter_user.listed_count,
        favourites_count: twitter_user.favourites_count
      )
    end

    followed_users_count = User.where('created_at >= ?', 3.hours.ago).count
    exit if rand(0..followed_users_count + 2) != 1

    followed_user_ids = User.ids
    count = 0
    limit_count = rand(5..12)
    users = TwitterApiService.fetch_users_by_keyword_search('#プロスピA')
    users.each do |user|
      next if followed_user_ids.include?(user.id)
      next if user.friends_count < 50
      next if user.followers_count < 50
      next if user.followers_count.to_f / user.friends_count > 1.6
      next if user.description.exclude?('プロスピ')

      TwitterApiService.follow(user)
      count += 1
      sleep rand(1.0..8.0)

      break if count >= limit_count
    end

    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping("#{count}人をフォローしました")
  rescue StandardError => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
