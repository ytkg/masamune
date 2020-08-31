# frozen_string_literal: true

namespace :tweet do
  task update: :environment do
    AdminUser.all.each do |admin_user|
      UpdateTweetBatch.new(admin_user).execute
    rescue StandardError => e
      Slack::NotificationService.call(e)
    end
  end
end
