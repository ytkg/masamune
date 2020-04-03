# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user_summaries = UserSummary.all
    @trends = Trend.where(result_date: Date.today).sample(10)
  end
end
