# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:id) { |n| n }
    sequence(:screen_name) { |n| "SCREEN_NAME#{n}" }
    sequence(:name) { |n| "NAME#{n}" }
    sequence(:image_url) { |n| "http://pbs.twimg.com/profile_images/#{n}/OwV2JC5B_normal.jpg" }
    sequence(:token) { |n| "TOKEN#{n}" }
    sequence(:secret) { |n| "SECRET#{n}" }
  end

  trait :with_detail do
    after(:build) do |admin_user|
      admin_user.detail = build(:detail)
    end
  end

  trait :with_tweet do
    after(:build) do |admin_user|
      admin_user.tweets << build(:tweet)
    end
  end

  trait :with_friend_user do
    after(:build) do |admin_user|
      twitter_user = build(:twitter_user)
      admin_user.friend_users << twitter_user
      admin_user.follow_users << twitter_user
    end
  end

  trait :with_follower_user do
    after(:build) do |admin_user|
      admin_user.friend_users << build(:twitter_user)
    end
  end
end
