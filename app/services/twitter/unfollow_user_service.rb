module Twitter
  class UnfollowUserService < Twitter::BaseService
    def self.call(user)
      client.unfollow(user)
    end
  end
end
