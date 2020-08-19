# frozen_string_literal: true

namespace :tweet do
  task fetch: :environment do
    FetchTweetsBatch.new.execute
  end
end
