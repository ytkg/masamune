FactoryBot.define do
  factory :tweet do
    sequence(:id) { |n| n }
    tweeted_at { Time.zone.now }
    sequence(:text) { |n| "TEXT#{n}" }
    retweet_count { rand(0..200) }
    favorite_count { rand(0..200) }
  end
end
