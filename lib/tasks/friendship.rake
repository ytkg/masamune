# frozen_string_literal: true

namespace :friendship do
  task update: :environment do
    AdminUser.all.each do |admin_user|
      UpdateFriendshipBatch.new(admin_user).execute
    rescue StandardError => e
      Slack::NotificationService.call(e)
    end
  end
end
