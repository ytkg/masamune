require 'rails_helper'

RSpec.describe UpdateSummaryBatch do
  describe '#execute' do
    let(:admin_user) { create(:admin_user) }
    let!(:tweet) { create(:tweet) }
    let(:user) { Twitter::User.new(JSON.parse(File.read('spec/json/user.json'), symbolize_names: true)) }

    before do
      allow(Twitter::FetchUserService).to receive(:call).and_return(user)
      described_class.new(admin_user).send(:execute)
    end

    it { expect(admin_user.summaries.count).to eq 1 }
    it {
      expect(admin_user.summaries.first).to have_attributes(
        friends_count: user.friends_count,
        followers_count: user.followers_count,
        statuses_count: user.statuses_count,
        retweet_count: tweet.retweet_count,
        favorite_count: tweet.favorite_count
      )
    }
  end
end
