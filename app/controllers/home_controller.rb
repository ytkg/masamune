class HomeController < ApplicationController
  def index
    @user_summary = UserSummary.last
    @user_summaries = UserSummary.all
    @trends = Trend.where(result_date: Date.today).sample(10)
  end
end
