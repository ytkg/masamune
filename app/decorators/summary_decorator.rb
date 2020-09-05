# frozen_string_literal: true

class SummaryDecorator < ApplicationDecorator
  delegate_all

  def ff_ratio
    (followers_count.to_f / friends_count).round(3)
  end
end
