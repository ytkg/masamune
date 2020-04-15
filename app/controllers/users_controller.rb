class UsersController < ApplicationController
  def index
    @friends = User.is_friend.decorate
    @followers = User.is_follower.decorate
    @friend_and_follower_users = @friends & @followers
  end
end
