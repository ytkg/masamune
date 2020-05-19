module Twitter
  class FetchFollowersService < Twitter::BaseService
    def self.call
      follower_ids = client.follower_ids.take(10000)
      Twitter::FetchUsersService.call(follower_ids)
    end
  end
end
