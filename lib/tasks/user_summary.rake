# frozen_string_literal: true

namespace :user_summary do
  task fetch: :environment do
    FetchUserSummaryBatch.new.execute
  end
end
