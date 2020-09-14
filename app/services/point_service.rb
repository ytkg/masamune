# frozen_string_literal: true

class PointService
  def initialize(admin_user, point)
    @admin_user = admin_user
    @point = point
  end

  def valid?
    @admin_user.points.sum(:value) + @point[:value] >= 0
  end

  def pay
    return false unless valid?

    @admin_user.points.create!(@point)
  end
end
