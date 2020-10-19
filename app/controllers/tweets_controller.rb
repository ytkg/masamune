# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = current_user.tweets.order(tweeted_at: :desc)
  end

  def new
    @tweets = current_user.tweets.order(tweeted_at: :desc).limit(5)
  end

  def create
    tweet = Twitter::TweetService.call(current_user.client, params[:tweet_text])
    current_user.tweets.update_or_create(tweet)
    PointService.new(current_user, Point::TWEET).pay
    session[:tweet] = nil
    flash[:success] = 'ツイートしました。'
    redirect_to action: :new
  rescue StandardError
    flash[:danger] = 'ツイート失敗しました'
    session[:tweet] = params['tweet_text']
    redirect_to action: :new
  end
end
