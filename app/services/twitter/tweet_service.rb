# frozen_string_literal: true

module Twitter
  class TweetService
    def self.call(client, text, option = {})
      client.update(text, option)
    end
  end
end
