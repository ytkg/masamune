# frozen_string_literal: true

namespace :user do
  task follow: :environment do
    followed_users_count = User.is_followed.where('created_at >= ?', 3.hours.ago).count
    exit if rand(0..followed_users_count + 2) != 1

    FollowUsersBatch.new(TwitterApi.new).execute
  rescue StandardError => e
    Slack::NotificationService.call(e)
  end
end
