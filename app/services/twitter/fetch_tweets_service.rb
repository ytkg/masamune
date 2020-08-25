module Twitter
  class FetchTweetsService
    def self.call(client)
      # TODO: 200件以上取れるロジックにする
      client.user_timeline(count: 200)
    end
  end
end
