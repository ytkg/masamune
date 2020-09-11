class SettingsController < ApplicationController
  def index
    @settings = current_user.detail.settings || {}
    @settings[:auto_follow] ||= {}
    @settings[:auto_follow][:search_keyword] ||= '#プロスピ'
    @settings[:auto_follow][:friends_count] ||= 50
    @settings[:auto_follow][:followers_count] ||= 50
  end

  def create
    current_user.detail.update_settings(
      {
        auto_follow: {
          search_keyword: params[:search_keyword].presence,
          friends_count: params[:friends_count].to_i,
          followers_count: params[:followers_count].to_i,
        }
      }
    )
  end
end
