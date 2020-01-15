namespace :user_summary do
  task fetch: :environment do
    user = TwitterApiService.fetch_user
    user_summary = UserSummary.find_or_initialize_by(result_date: Date.today)
    user_summary.update(friends_count: user.friends_count, followers_count: user.followers_count, statuses_count: user.statuses_count)
  end
end
