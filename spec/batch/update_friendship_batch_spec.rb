require 'rails_helper'

RSpec.describe UpdateFriendshipBatch do
  describe '#update_friends' do
    let(:admin_user) { create(:admin_user, :with_friend_user) }
    let(:friends) { JSON.parse(File.read('spec/json/friends.json'), symbolize_names: true).map{ |u| Twitter::User.new(u) } }

    before do
      allow(Twitter::FetchFriendsService).to receive(:call).and_return(friends)
      described_class.new(admin_user).send(:update_friends)
    end

    subject { admin_user.friends.pluck(:twitter_user_id) }

    it { expect(TwitterUser.count).to eq friends.count + 1 }
    it { expect(admin_user.friends.pluck(:twitter_user_id)).to match_array(friends.map(&:id)) }
  end

  describe '#update_followers' do
    let(:admin_user) { create(:admin_user, :with_friend_user) }
    let(:followers) { JSON.parse(File.read('spec/json/followers.json'), symbolize_names: true).map{ |u| Twitter::User.new(u) } }

    before do
      allow(Twitter::FetchFollowersService).to receive(:call).and_return(followers)
      described_class.new(admin_user).send(:update_followers)
    end

    subject { admin_user.followers.pluck(:twitter_user_id) }

    it { expect(TwitterUser.count).to eq followers.count + 1 }
    it { expect(admin_user.followers.pluck(:twitter_user_id)).to match_array(followers.map(&:id)) }
  end
end
