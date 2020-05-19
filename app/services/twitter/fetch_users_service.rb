module Twitter
  class FetchUsersService < Twitter::BaseService
    def self.call(ids)
      client.users(ids)
    end
  end
end
