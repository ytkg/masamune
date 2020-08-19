module Twitter
  class FetchUserService < Twitter::BaseService
    def self.call
      client.user
    end
  end
end
