require 'rails_helper'

RSpec.describe FetchTweetsBatch do
  describe '#execute' do
    before do
      tweets = JSON.parse(File.read('spec/json/tweets.json'), symbolize_names: true).map{|t| Twitter::Tweet.new(t)}
      fetch_tweets_batch = described_class.new(anything)
      allow(fetch_tweets_batch).to receive(:fetch_tweets).and_return(tweets)
      fetch_tweets_batch.execute
    end

    it do
      expect(Tweet.first).to have_attributes(id: 1259712455153815600,
                                             tweeted_at: Time.zone.parse('2020-05-11 14:10:28'),
                                             text: "過去一ねばった\nどうせなら30くらいいきたかったな\n\n#プロスピA https://t.co/Koy7CcSUBd",
                                             retweet_count: 0,
                                             favorite_count: 18)
    end
  end
end
