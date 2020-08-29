class CreateSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :summaries do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.date :result_date
      t.integer :friends_count
      t.integer :followers_count
      t.integer :statuses_count
      t.integer :retweet_count
      t.integer :favorite_count

      t.timestamps
    end
  end
end
