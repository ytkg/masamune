# frozen_string_literal: true

class User < ApplicationRecord
  scope :is_followed, -> { where(followed: true) }
end
