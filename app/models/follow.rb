class Follow < ApplicationRecord
  belongs_to :admin_user
  belongs_to :twitter_user
end
