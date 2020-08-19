# frozen_string_literal: true

class FetchUserSummaryBatch
  def execute
    user = fetch_user
    user_summary = UserSummary.find_or_initialize_by(result_date: Time.zone.today)
    user_summary.update(
      name: user.name,
      screen_name: user.screen_name,
      profile_image_url_https: user.profile_image_url_https,
      friends_count: user.friends_count,
      followers_count: user.followers_count,
      statuses_count: user.statuses_count,
      retweet_count: Tweet.sum(:retweet_count),
      favorite_count: Tweet.sum(:favorite_count)
    )
  end

  private

  def fetch_user
    Twitter::FetchUserService.call
  end
end
