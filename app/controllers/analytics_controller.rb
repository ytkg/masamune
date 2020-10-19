# frozen_string_literal: true

class AnalyticsController < ApplicationController
  def followers
    users = current_user.friend_users
    @tweet_charts = set_charts(users, :statuses_count)
    @follow_charts = set_charts(users, :friends_count)
    @follower_charts = set_charts(users, :followers_count)
  end

  private

  def set_charts(users, column)
    charts = users.each_with_object(Hash.new(0)) do |user, hash|
      hash[user.range(column)] += 1
    end
    charts.sort_by { |k, _| k.to_i }
  end
end
