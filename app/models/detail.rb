class Detail < ApplicationRecord
  attribute :value, :text, default: '{}'
  belongs_to :admin_user
end
