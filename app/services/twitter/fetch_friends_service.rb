module Twitter
  class FetchFriendsService
    def self.call(client)
      friend_ids = client.friend_ids.take(10000)
      Twitter::FetchUsersService.call(client, friend_ids)
    end
  end
end
