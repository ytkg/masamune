# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :logged_in?
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= AdminUser.find(session[:user_id])
  end

  def logged_in?
    if session[:user_id]
      @current_user ||= AdminUser.find(session[:user_id])
    end

    return if @current_user

    redirect_to login_path
  end
end
