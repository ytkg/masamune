# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = current_user.tweets.order(tweeted_at: :desc)
  end

  def new; end

  def create; end
end
