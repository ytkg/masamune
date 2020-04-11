class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(tweeted_at: :desc)
  end
end
