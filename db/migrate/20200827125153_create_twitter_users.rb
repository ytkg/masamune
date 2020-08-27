class CreateTwitterUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :twitter_users, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.string :screen_name
      t.string :name
      t.integer :statuses_count, default: 0
      t.integer :friends_count, default: 0
      t.integer :followers_count, default: 0
      t.integer :listed_count, default: 0
      t.integer :favourites_count , default: 0

      t.timestamps
    end
  end
end
