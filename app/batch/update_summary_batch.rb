# frozen_string_literal: true

class UpdateSummaryBatch
  def initialize(admin_user)
    @admin_user = admin_user
    @client = admin_user.client
  end

  def execute
    user = Twitter::FetchUserService.call(@client)
    summary = @admin_user.summaries.find_or_initialize_by(result_date: Time.zone.today)
    summary.update(
      friends_count: user.friends_count,
      followers_count: user.followers_count,
      statuses_count: user.statuses_count,
      retweet_count: @admin_user.tweets.sum(:retweet_count),
      favorite_count: @admin_user.tweets.sum(:favorite_count)
    )
  end
end
