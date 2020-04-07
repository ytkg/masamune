class AnalyticsController < ApplicationController
  def followers
    users = User.where(is_follower: true)
    @tweet_charts    = set_charts(users, :statuses_count)
    @follow_charts   = set_charts(users, :friends_count)
    @follower_charts = set_charts(users, :followers_count)
  end

  private

  def set_charts(users, column)
    initial_hash = {
      '0-99'       => 0,
      '100-499'    => 0,
      '500-999'    => 0,
      '1000-4999'  => 0,
      '5000-49999' => 0,
      '50000-'     => 0
    }
    users.each_with_object(initial_hash) do |user, hash|
      case user.send(column)
      when 0..99
        hash['0-99'] += 1
      when 100..499
        hash['100-499'] += 1
      when 500..999
        hash['500-999'] += 1
      when 1000..4999
        hash['1000-4999'] += 1
      when 5000..49999
        hash['5000-49999'] += 1
      else
        hash['50000-'] += 1
      end
    end
  end
end
