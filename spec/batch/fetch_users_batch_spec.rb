require 'rails_helper'

RSpec.describe FetchUsersBatch do
  describe '#execute' do
    before do
      fetch_users_batch = described_class.new(anything)
      friends = JSON.parse(File.read('spec/json/friends.json'), symbolize_names: true).map{|u| Twitter::User.new(u)}
      allow(fetch_users_batch).to receive(:fetch_friends).and_return(friends)
      followers = JSON.parse(File.read('spec/json/followers.json'), symbolize_names: true).map{|u| Twitter::User.new(u)}
      allow(fetch_users_batch).to receive(:fetch_followers).and_return(followers)
      fetch_users_batch.execute
    end

    it { expect(User.count).to eq 20 }
    it { expect(User.is_follower.count).to eq 10 }
    it { expect(User.is_not_follower.count).to eq 10 }
    it { expect(User.is_friend.count).to eq 10 }
    it { expect(User.is_followed.count).to eq 10 }

    it do
      expect(User.is_follower.first).to have_attributes(id: 868694873725059100,
                                                        screen_name: "EaglesRakutenCh",
                                                        statuses_count: 5443,
                                                        friends_count: 2926,
                                                        followers_count: 3898,
                                                        listed_count: 18,
                                                        favourites_count: 4,
                                                        is_follower: true,
                                                        is_friend: false,
                                                        followed: false)
    end

    it do
      expect(User.is_friend.first).to have_attributes(id: 790127165094268900,
                                                      screen_name: "G6hayato344",
                                                      statuses_count: 3669,
                                                      friends_count: 1559,
                                                      followers_count: 1006,
                                                      listed_count: 3,
                                                      favourites_count: 9467,
                                                      is_follower: false,
                                                      is_friend: true,
                                                      followed: true)
    end
  end
end
