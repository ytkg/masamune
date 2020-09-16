# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @settings = current_user.detail.settings || {}
    @settings[:auto_follow] ||= {}
    @settings[:auto_follow][:search_keyword] ||= '#プロスピ'
    @settings[:auto_follow][:friends_count_ge] ||= 50
    @settings[:auto_follow][:friends_count_le] ||= 10000
    @settings[:auto_follow][:followers_count_ge] ||= 50
    @settings[:auto_follow][:followers_count_le] ||= 10000
  end

  def create
    current_user.detail.update_settings(
      {
        auto_follow: {
          enabled: params[:auto_follow_enabled].presence,
          search_keyword: params[:search_keyword].presence,
          friends_count_ge: params[:friends_count_ge].to_i,
          friends_count_le: params[:friends_count_le].to_i,
          followers_count_ge: params[:followers_count_ge].to_i,
          followers_count_le: params[:followers_count_le].to_i
        }
      }
    )
  end
end
