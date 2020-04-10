# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @tweet_by_year_month = Tweet.select("date_trunc('month', tweeted_at) as year_month")
                                .select('count(id) as total_tweet_count')
                                .select('sum(retweet_count) as total_retweet_count')
                                .select('sum(favorite_count) as total_favorite_count')
                                .group("date_trunc('month', tweeted_at)")
                                .order(year_month: :desc)
  end
end
