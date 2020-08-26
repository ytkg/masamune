# frozen_string_literal: true

class FollowUsersBatch
  def initialize(client)
    @client = client
  end

  def execute
    users = fetch_users_to_follow
    follow_users(users)

    Slack::NotificationService.call("#{users.count}人をフォローしました")
  end

  private

  def fetch_users_from_search(keyword)
    Twitter::FetchUsersByKeywordSearchService.call(@client, keyword)
  end

  def fetch_users_to_follow
    followed_user_ids = User.is_followed.ids
    count = 0
    limit_count = rand(5..12)
    users_from_search = fetch_users_from_search('#プロスピA')
    users_from_search.each_with_object([]) do |user, arr|
      next if followed_user_ids.include?(user.id)
      next if user.friends_count < 50
      next if user.followers_count < 50
      next if user.followers_count.to_f / user.friends_count > 1.6
      next if user.description.exclude?('プロスピ')
      next if count >= limit_count

      arr.push(user)
      count += 1
    end
  end

  def follow_users(users)
    users.each do |user|
      Twitter::FollowUserService.call(@client, user)
      sleep rand(1.0..8.0)
    end
  end
end
