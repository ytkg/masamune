require 'rails_helper'

RSpec.describe UpdateTweetBatch do
  describe '#execute' do
    let(:admin_user) { create(:admin_user, :with_friend_user) }
    let(:tweets) { JSON.parse(File.read('spec/json/tweets.json'), symbolize_names: true).map{ |t| Twitter::Tweet.new(t) } }
    let(:tweets_without_rt) { tweets.select{ |t| !t.text.match(/^RT @/) } }

    before do
      allow(Twitter::FetchTweetsService).to receive(:call).and_return(tweets)
      described_class.new(admin_user).execute
    end

    it { expect(admin_user.tweets.count).to eq tweets_without_rt.count }
    it { expect(admin_user.tweets.pluck(:id)).to match_array(tweets_without_rt.map(&:id)) }
  end
end