# frozen_string_literal: true

namespace :summary do
  task update: :environment do
    AdminUser.all.each do |admin_user|
      UpdateSummaryBatch.new(admin_user).execute
    rescue StandardError => e
      Slack::NotificationService.call(e)
    end
  end
end
