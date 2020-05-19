module Twitter
  class FetchUsersByKeywordSearchService < Twitter::BaseService
    def self.call(keyword)
      client.search(keyword).take(3000).map(&:user).uniq
    end
  end
end
