# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user
    @user = UserSummary.last
  end
end
