class UsersController < ApplicationController
  def index
    @friends = User.is_friend
    @followers = User.is_follower
  end
end
