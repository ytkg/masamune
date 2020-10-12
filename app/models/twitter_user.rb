# frozen_string_literal: true

class TwitterUser < ApplicationRecord
  def self.update_or_create(user)
    find_or_initialize_by(id: user.id).tap do |twitter_user|
      twitter_user.update!(
        screen_name: user.screen_name,
        name: user.name,
        description: user.description,
        profile_image_url_https: user.profile_image_url_https,
        statuses_count: user.statuses_count,
        friends_count: user.friends_count,
        followers_count: user.followers_count,
        listed_count: user.listed_count,
        favourites_count: user.favourites_count
      )
    end
  end

  def range(column)
    case send(column)
    when 0..99 then '0-99'
    when 100..499 then '100-499'
    when 500..999 then '500-999'
    when 1000..4999 then '1000-4999'
    when 5000..49999 then '5000-49999'
    else '50000-'
    end
  end
end
