module Twitter
  class FetchFriendsService < Twitter::BaseService
    def self.call
      friend_ids = client.friend_ids.take(10000)
      Twitter::FetchUsersService.call(friend_ids)
    end
  end
end
