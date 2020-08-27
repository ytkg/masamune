module Twitter
  class FollowUserService
    def self.call(client, user)
      client.follow(user)
    end
  end
end
