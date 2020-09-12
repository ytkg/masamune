# frozen_string_literal: true

module Twitter
  class FetchUserService
    def self.call(client)
      client.user
    end
  end
end
