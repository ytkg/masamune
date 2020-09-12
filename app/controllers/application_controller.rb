# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :logged_in?
  before_action :update_last_login_at
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def current_user
    return unless session[:user_id]

    @current_user ||= AdminUser.find(session[:user_id])
  end

  def logged_in?
    @current_user ||= AdminUser.find(session[:user_id]) if session[:user_id]

    return if @current_user

    redirect_to login_path
  end

  def update_last_login_at
    return unless current_user

    current_user.build_detail unless current_user.detail

    if current_user.detail.last_login_date != Time.zone.today.to_s(:db)
      current_user.points.create({ name: 'ログインボーナス', value: 10 })
    end

    # パラメータが確定するまではここで必ず初期化するようにする
    current_user.detail.update_daily_mission({ mission_1: false, mission_2: false, mission_3: false, mission_4: false })

    current_user.detail.update_last_login_date(Time.zone.today.to_s(:db))
  end
end
