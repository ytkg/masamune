class CreateUserSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :user_summaries do |t|
      t.date :result_date
      t.integer :friends_count
      t.integer :followers_count
      t.integer :statuses_count

      t.timestamps
    end
  end
end
