module Twitter
  class FetchUsersByKeywordSearchService
    def self.call(client, keyword)
      client.search(keyword).take(3000).map(&:user).uniq
    end
  end
end
