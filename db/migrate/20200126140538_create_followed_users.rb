class CreateFollowedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :followed_users do |t|
      t.integer :twitter_id

      t.timestamps
    end
  end
end
