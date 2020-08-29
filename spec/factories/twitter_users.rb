FactoryBot.define do
  factory :twitter_user do
    sequence(:id) { |n| n }
    sequence(:screen_name) { |n| "SCREEN_NAME#{n}"}
    sequence(:name) { |n| "NAME#{n}"}
  end
end
