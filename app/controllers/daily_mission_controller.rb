class DailyMissionController < ApplicationController
  def index
    @daily_mission = current_user.detail.daily_mission
  end
end
