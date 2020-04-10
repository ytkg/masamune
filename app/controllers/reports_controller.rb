class ReportsController < ApplicationController
  def index
    @tweet_by_year_month = Tweet.select("date_trunc('month', tweeted_at) AS year_month, count(id) as total_tweet_count, sum(retweet_count) as total_retweet_count, sum(favorite_count) as total_favorite_count").group("date_trunc('month', tweeted_at)").order(year_month: :desc)
  end
end
