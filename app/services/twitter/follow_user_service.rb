module Twitter
  class FollowUserService < Twitter::BaseService
    def self.call(user)
      client.follow(user)
    end
  end
end
