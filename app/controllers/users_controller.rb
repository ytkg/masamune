class UsersController < ApplicationController
  def index
    @friends = User.is_friend.decorate
    @followers = User.is_follower.decorate
  end
end
