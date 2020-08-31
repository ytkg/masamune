# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :admin_user
end
