class TwitterUser < ApplicationRecord
  def self.update_or_create(user)
    find_or_initialize_by(id: user.id).tap do |twitter_user|
      twitter_user.update!(
        screen_name: user.screen_name,
        name: user.name,
        statuses_count: user.statuses_count,
        friends_count: user.friends_count,
        followers_count: user.followers_count,
        listed_count: user.listed_count,
        favourites_count: user.favourites_count
      )
    end
  end
end
