# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :admin_user

  LOGIN_BONUS = { name: 'ログインボーナス', value: 10 }.freeze
  TWEET = { name: 'ツイート', value: 1 }.freeze
  USER_FOLLOW = { name: 'ユーザーフォロー', value: -1 }.freeze
  USER_UNFOLLOW = { name: 'ユーザーフォロー解除', value: -1 }.freeze
  AUTO_FOLLOW = { name: '自動フォロー', value: -5 }.freeze
end
