# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :admin_user
  belongs_to :twitter_user
end
