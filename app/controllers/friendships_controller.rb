# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
    @friend_users = current_user.friends.includes(:twitter_user).order(created_at: :desc)
    @follower_users = current_user.followers.includes(:twitter_user).order(created_at: :desc)
    @friend_and_follower_users = @friend_users.where(twitter_user_id: @follower_users.map(&:twitter_user_id))
    @friend_except_follower_users = @friend_users.where.not(twitter_user_id: @follower_users.map(&:twitter_user_id))
    @follower_except_friend_users = @follower_users.where.not(twitter_user_id: @friend_users.map(&:twitter_user_id))
  end

  def follow
    @point = Point::USER_FOLLOW
    point_service = PointService.new(current_user, Point::USER_FOLLOW)
    if point_service.pay
      @twitter_user_id = params[:twitter_id].to_i
      Twitter::FollowUserService.call(current_user.client, @twitter_user_id)
      current_user.friends.find_or_create_by(twitter_user_id: @twitter_user_id)
      @success = true
    else
      @success = false
    end
  end
end
