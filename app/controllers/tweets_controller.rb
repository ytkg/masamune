# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = current_user.tweets.order(tweeted_at: :desc)
  end

  def new; end

  def create
    Twitter::TweetService.call(current_user.client, params[:tweet_text])
    session[:tweet] = nil
    flash[:success] = 'ツイートしました。'
    redirect_to action: :new
  rescue => ex
    flash[:danger] = 'ツイート失敗しました'
    session[:tweet] = params['tweet_text']
    redirect_to action: :new
  end
end
