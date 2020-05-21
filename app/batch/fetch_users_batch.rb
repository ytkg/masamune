# frozen_string_literal: true

class FetchUsersBatch
  def execute
    User.all.each { |user| user.update(is_follower: false, is_friend: false) }

    twitter_users = fetch_friends
    twitter_users.each do |twitter_user|
      upsert_user(twitter_user, is_friend: true, is_followed: true)
    end

    twitter_users = fetch_followers
    twitter_users.each do |twitter_user|
      upsert_user(twitter_user, is_follower: true)
    end
  end

  private

  def fetch_friends
    Twitter::FetchFriendsService.call
  end

  def fetch_followers
    Twitter::FetchFollowersService.call
  end

  def upsert_user(twitter_user, is_follower: false, is_friend: false, is_followed: false)
    user = User.find_or_initialize_by(id: twitter_user.id)
    user.update(
      screen_name: twitter_user.screen_name,
      statuses_count: twitter_user.statuses_count,
      friends_count: twitter_user.friends_count,
      followers_count: twitter_user.followers_count,
      listed_count: twitter_user.listed_count,
      favourites_count: twitter_user.favourites_count,
      is_follower: is_follower,
      is_friend: is_friend,
      followed: is_followed
    )
  end
end
