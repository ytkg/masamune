module Slack
  class NotificationService
    class << self
      def call(message)
        Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(message)
      end
    end
  end
end
