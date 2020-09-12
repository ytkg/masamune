# frozen_string_literal: true

class UpdateFriendshipBatch
  def initialize(admin_user)
    @admin_user = admin_user
    @client = admin_user.client
  end

  def execute
    update_friends
    update_followers
  end

  private

  def update_friends
    friends = Twitter::FetchFriendsService.call(@client)
    friends.each do |friend|
      twitter_user = TwitterUser.update_or_create(friend)
      @admin_user.friends.find_or_create_by(twitter_user_id: twitter_user.id)
      @admin_user.follows.find_or_create_by(twitter_user_id: twitter_user.id)
    end
    @admin_user.friends.where.not(twitter_user_id: friends.map(&:id)).delete_all
  end

  def update_followers
    followers = Twitter::FetchFollowersService.call(@client)
    followers.each do |follower|
      twitter_user = TwitterUser.update_or_create(follower)
      @admin_user.followers.find_or_create_by(twitter_user_id: twitter_user.id)
    end
    @admin_user.followers.where.not(twitter_user_id: followers.map(&:id)).delete_all
  end
end
