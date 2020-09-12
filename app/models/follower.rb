# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :admin_user
  belongs_to :twitter_user
end
