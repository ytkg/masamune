require 'rails_helper'

RSpec.describe FollowUsersBatch do
  describe '#fetch_users_to_follow' do
    let(:follow_users_batch) { described_class.new(anything) }

    before do
      users = JSON.parse(File.read('spec/json/users.json'), symbolize_names: true).map{|u| Twitter::User.new(u)}
      allow(follow_users_batch).to receive(:fetch_users_from_search).and_return(users)
      allow(follow_users_batch).to receive(:rand).and_return(10)
    end

    subject { follow_users_batch.send(:fetch_users_to_follow).count }

    it { is_expected.to eq 5 }
  end
end
