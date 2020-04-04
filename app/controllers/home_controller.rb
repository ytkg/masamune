# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user_summaries = UserSummary.all
    @popular_tweets_by_favorite_count = Tweet.order(favorite_count: :desc).limit(3)
    @popular_tweets_by_retweet_count = Tweet.order(retweet_count: :desc).limit(3)
    @trends = Trend.where(result_date: Date.today).sample(10)
  end
end
