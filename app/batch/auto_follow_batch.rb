# frozen_string_literal: true

class AutoFollowBatch
  def initialize(admin_user)
    @admin_user = admin_user
    @client = admin_user.client
  end

  def execute
    settings = @admin_user.detail.settings

    return unless settings && settings[:auto_follow] && settings[:auto_follow][:enabled]

    point_service = PointService.new(@admin_user, Point::AUTO_FOLLOW)
    return unless point_service.pay

    users = fetch_users_to_follow(settings[:auto_follow])
    follow_users(users.take(5))
  end

  private

  def fetch_users_to_follow(auto_follow_setting) # rubocop:disable all
    followed_twitter_user_ids = @admin_user.follows.pluck(:twitter_user_id)
    users = Twitter::FetchUsersByKeywordSearchService.call(@client, auto_follow_setting[:search_keyword])
    users.each_with_object([]) do |user, arr|
      next if user.id == @admin_user.id
      next if followed_twitter_user_ids.include?(user.id)
      next if user.friends_count < auto_follow_setting[:friends_count_ge]
      next if user.friends_count > auto_follow_setting[:friends_count_le]
      next if user.followers_count < auto_follow_setting[:followers_count_ge]
      next if user.followers_count > auto_follow_setting[:followers_count_le]
      next if (user.followers_count + 0.1) / (user.friends_count + 0.1) < auto_follow_setting[:ff_ratio_ge]
      next if (user.followers_count + 0.1) / (user.friends_count + 0.1) > auto_follow_setting[:ff_ratio_le]

      arr.push(user)
    end
  end

  def follow_users(users)
    users.each do |user|
      Twitter::FollowUserService.call(@client, user)
      sleep rand(1.0..8.0)
    end
  end
end
