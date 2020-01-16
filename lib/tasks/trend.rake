namespace :trend do
  task fetch: :environment do
    trends = TwitterApiService.fetch_trends
    trends.each do |record|
      trend = Trend.find_or_create_by(result_date: Date.today, name: record[:name])
      trend.update(url: record[:url], tweet_volume: record[:tweet_volume])
    end
  end

  task delete: :environment do
    Trend.where.not(result_date: Date.today..Float::INFINITY).delete_all
  end
end
