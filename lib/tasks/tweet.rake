# frozen_string_literal: true

namespace :tweet do
  task fetch: :environment do
    UpdateTweetBatch.new(AdminUser.find(1216390208209293313)).execute
  end
end
