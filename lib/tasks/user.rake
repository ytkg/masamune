namespace :user do
  task follow: :environment do
    exit if rand(1..12) != 1
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping('実行')
  rescue => e
    Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']).ping(e)
  end
end
