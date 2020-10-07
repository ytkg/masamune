class AdminUsersController < ApplicationController
  def index
    @admin_users = AdminUser.all
  end
end
