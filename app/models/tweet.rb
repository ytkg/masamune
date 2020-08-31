# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :admin_user

  def self.update_or_create(tweet)
    find_or_initialize_by(id: tweet.id).tap do |tweet_|
      tweet_.update!(
        tweeted_at: tweet.created_at,
        text: tweet.text,
        retweet_count: tweet.retweet_count,
        favorite_count: tweet.favorite_count
      )
    end
  end
end
