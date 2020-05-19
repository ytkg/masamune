module Twitter
  class FetchTweetsService < Twitter::BaseService
    def self.call
      # TODO: 200件以上取れるロジックにする
      client.user_timeline(count: 200)
    end
  end
end
