class AddColumnRetweetCountAndFavoriteCountToUserSummaries < ActiveRecord::Migration[6.0]
  def change
    add_column :user_summaries, :retweet_count, :integer, after: :statuses_count
    add_column :user_summaries, :favorite_count, :integer, after: :retweet_count
  end
end
