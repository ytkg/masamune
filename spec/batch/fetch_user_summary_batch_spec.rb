require 'rails_helper'

RSpec.describe FetchUserSummaryBatch do
  describe '#execute' do
    before do
      user = Twitter::User.new(JSON.parse(File.read('spec/json/user.json'), symbolize_names: true))
      fetch_user_summary_batch = described_class.new(anything)
      allow(fetch_user_summary_batch).to receive(:fetch_user).and_return(user)
      fetch_user_summary_batch.execute
    end

    it do
      expect(UserSummary.first).to have_attributes(name: 'よっぴ',
                                                   screen_name: 'ytkg_dev',
                                                   profile_image_url_https: 'https://pbs.twimg.com/profile_images/1217102670705524736/OwV2JC5B_normal.jpg',
                                                   friends_count: 1603,
                                                   followers_count: 1746,
                                                   statuses_count: 228)
    end
  end
end
