# frozen_string_literal: true

namespace :user do
  task fetch: :environment do
    User.all.update_all(is_follower: false, is_friend: false)

    friend_ids    = TwitterApiService.fetch_friend_ids
    twitter_users = TwitterApiService.fetch_users(friend_ids)
    twitter_users.each do |twitter_user|
      user = User.find_or_initialize_by(id: twitter_user.id)
      user.update(
        screen_name:      twitter_user.screen_name,
        statuses_count:   twitter_user.statuses_count,
        friends_count:    twitter_user.friends_count,
        followers_count:  twitter_user.followers_count,
        listed_count:     twitter_user.listed_count,
        favourites_count: twitter_user.favourites_count,
        is_friend:        true,
        followed:         true
      )
    end

    follower_ids  = TwitterApiService.fetch_follower_ids
    twitter_users = TwitterApiService.fetch_users(follower_ids)
    twitter_users.each do |twitter_user|
      user = User.find_or_initialize_by(id: twitter_user.id)
      user.update(
        screen_name:      twitter_user.screen_name,
        statuses_count:   twitter_user.statuses_count,
        friends_count:    twitter_user.friends_count,
        followers_count:  twitter_user.followers_count,
        listed_count:     twitter_user.listed_count,
        favourites_count: twitter_user.favourites_count,
        is_follower:      true,
      )
    end
  end

  task follow: :environment do
    followed_users_count = User.is_followed.where('created_at >= ?', 3.hours.ago).count
    exit if rand(0..followed_users_count + 2) != 1

    followed_user_ids = User.is_followed.ids
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

  task unfollow: :environment do
    count = 0
    limit_count = rand(2..5)
    users = User.is_friend.is_not_follower.where('created_at < ?', 2.weeks.ago).limit(limit_count)
    users.each do |user|
      twitter_user = TwitterApiService.fetch_users(user.id).first
      if twitter_user.present?
        TwitterApiService.unfollow(twitter_user)
        user.update(is_friend: false)
        count += 1
        sleep rand(1.0..8.0)
      end
    end

    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping("#{count}人をアンフォローしました")
  rescue StandardError => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
