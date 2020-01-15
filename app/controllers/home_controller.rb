class HomeController < ApplicationController
  def index
    @trends = Trend.where(result_date: Date.today).sample(10)
  end
end
