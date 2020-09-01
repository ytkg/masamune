# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user_summaries = current_user.summaries
    @popular_tweets_by_favorite_count = current_user.tweets.order(favorite_count: :desc).limit(3)
    @popular_tweets_by_retweet_count = current_user.tweets.order(retweet_count: :desc).limit(3)
  end
end
