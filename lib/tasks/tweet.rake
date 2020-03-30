namespace :tweet do
  task fetch: :environment do
    user_tweets = TwitterApiService.fetch_tweets
    user_tweets.each do |user_tweet|
      tweet = Tweet.find_or_initialize_by(id:  user_tweet.id)
      tweet.update(
        tweeted_at: user_tweet.created_at,
        text: user_tweet.text,
        retweet_count: user_tweet.retweet_count,
        favorite_count: user_tweet.favorite_count
      )
    end
  end
end
