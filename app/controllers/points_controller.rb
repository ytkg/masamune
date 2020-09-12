# frozen_string_literal: true

class PointsController < ApplicationController
  def index
    @points = current_user.points.order(created_at: :desc)
  end
end
