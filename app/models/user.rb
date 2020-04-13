# frozen_string_literal: true

class User < ApplicationRecord
  scope :is_follower, -> { where(is_follower: true) }
  scope :is_not_follower, -> { where(is_follower: false) }
  scope :is_friend, -> { where(is_friend: true) }
  scope :is_followed, -> { where(followed: true) }

  def ff_ratio
    (friends_count.to_f / followers_count).round(2)
  end
end
