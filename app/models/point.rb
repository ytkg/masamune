# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :admin_user

  USER_FOLLOW = { name: 'ユーザーフォロー', value: -1 }
  AUTO_FOLLOW = { name: '自動フォロー', value: -5 }
end
