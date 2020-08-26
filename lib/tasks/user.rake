# frozen_string_literal: true

namespace :user do
  task fetch: :environment do
    FetchUsersBatch.new(TwitterApi.new).execute
  end

  task follow: :environment do
    followed_users_count = User.is_followed.where('created_at >= ?', 3.hours.ago).count
    exit if rand(0..followed_users_count + 2) != 1

    FollowUsersBatch.new.execute
  rescue StandardError => e
    Slack::NotificationService.call(e)
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
