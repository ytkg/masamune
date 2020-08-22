# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_user
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def set_user
    @user = UserSummary.last
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= AdminUser.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end
end
