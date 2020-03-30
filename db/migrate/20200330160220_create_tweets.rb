class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.datetime :tweeted_at
      t.text :text
      t.integer :retweet_count, default: 0
      t.integer :favorite_count, default: 0

      t.timestamps
    end
  end
end
