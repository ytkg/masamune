# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @settings = current_user.detail.settings || { auto_follow: {} }
  end

  def create
    current_user.detail.update_settings({ auto_follow: auto_follow_params })
  end

  private

  def auto_follow_params
    {
      enabled: params[:auto_follow_enabled].presence,
      search_keyword: params[:search_keyword].presence,
      friends_count_ge: params[:friends_count_ge].to_i,
      friends_count_le: params[:friends_count_le].to_i,
      followers_count_ge: params[:followers_count_ge].to_i,
      followers_count_le: params[:followers_count_le].to_i,
      ff_ratio_ge: params[:ff_ratio_ge].to_f,
      ff_ratio_le: params[:ff_ratio_le].to_f
    }
  end
end
