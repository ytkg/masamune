# frozen_string_literal: true

module Twitter
  class FetchFollowersService
    def self.call(client)
      follower_ids = client.follower_ids.take(10000)
      Twitter::FetchUsersService.call(client, follower_ids)
    end
  end
end
