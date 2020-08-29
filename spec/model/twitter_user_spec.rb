require 'rails_helper'

RSpec.describe TwitterUser, type: :model do
  describe '.update_or_create' do
    let(:user) { Twitter::User.new(JSON.parse(File.read('spec/json/twitter_user.json'), symbolize_names: true)) }

    it do
      twitter_user = described_class.update_or_create(user)
      expect(user).to have_attributes(id: user.id,
                                      screen_name: user.screen_name,
                                      name: user.name,
                                      statuses_count: user.statuses_count,
                                      friends_count: user.friends_count,
                                      followers_count: user.followers_count,
                                      listed_count: user.listed_count,
                                      favourites_count: user.favourites_count)
    end
  end
end