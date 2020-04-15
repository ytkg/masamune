# frozen_string_literal: true

class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(tweeted_at: :desc)
  end
end
