module Twitter
  class UnfollowUserService 
    def self.call(client, user)
      client.unfollow(user)
    end
  end
end
