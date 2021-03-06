class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.references :twitter_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
