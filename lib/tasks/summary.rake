# frozen_string_literal: true

namespace :summary do
  task update: :environment do
    UpdateSummaryBatch.new(AdminUser.find(1216390208209293313)).execute
  end
end
