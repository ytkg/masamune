class SessionsController < ApplicationController
  def create
    user = AdminUser.create_or_update_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:notice] = 'ログインしました。'
    redirect_to root_path
  end

  def destroy
    reset_session
    flash[:notice] = 'ログアウトしました。'
    redirect_to root_path
  end
end
