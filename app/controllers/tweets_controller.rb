# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = current_user.tweets.order(tweeted_at: :desc)
  end
end
