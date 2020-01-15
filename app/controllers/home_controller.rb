class HomeController < ApplicationController
  def index
    @user_summary = UserSummary.last
    @trends = Trend.where(result_date: Date.today).sample(10)
  end
end
