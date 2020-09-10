class FriendshipsController < ApplicationController
  def index
    @friend_users = current_user.friend_users.order(created_at: :desc).decorate
    @follower_users = current_user.follower_users.order(created_at: :desc).decorate
    @friend_and_follower_users = @friend_users & @follower_users
    @friend_except_follower_users = @friend_users - @follower_users
    @follower_except_friend_users = @follower_users - @friend_users
  end
end
