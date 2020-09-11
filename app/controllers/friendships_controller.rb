class FriendshipsController < ApplicationController
  def index
    @friend_users = current_user.friend_users.order(created_at: :desc).decorate
    @follower_users = current_user.follower_users.order(created_at: :desc).decorate
    @friend_and_follower_users = @friend_users & @follower_users
    @friend_except_follower_users = @friend_users - @follower_users
    @follower_except_friend_users = @follower_users - @friend_users
  end

  def follow
    twitter_user_id = params[:twitter_id].to_i
    Twitter::FollowUserService.call(current_user.client, twitter_user_id)
    @twitter_user_id = current_user.friends.find_or_create_by(twitter_user_id: twitter_user_id).twitter_user_id
  end
end
