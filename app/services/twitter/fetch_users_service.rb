# frozen_string_literal: true

module Twitter
  class FetchUsersService
    def self.call(client, ids)
      client.users(ids)
    end
  end
end
