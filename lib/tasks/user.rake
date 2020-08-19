# frozen_string_literal: true

namespace :user do
  task fetch: :environment do
    FetchUsersBatch.new.execute
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

  task delete: :environment do
    users = TwitterApiService.fetch_users(User.ids)
    User.where.not(id: users.map(&:id)).delete_all
  end
end
