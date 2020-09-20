# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '.update_or_create' do
    let(:admin_user) { create(:admin_user) }
    let(:tweet) { Twitter::Tweet.new(JSON.parse(File.read('spec/json/tweet.json'), symbolize_names: true)) }

    subject { admin_user.tweets.update_or_create(tweet) }

    it do
      is_expected.to have_attributes(id: tweet.id,
                                     tweeted_at: tweet.created_at,
                                     text: tweet.text,
                                     retweet_count: tweet.retweet_count,
                                     favorite_count: tweet.favorite_count)
    end
  end
end
