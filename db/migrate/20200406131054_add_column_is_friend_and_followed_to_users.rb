class AddColumnIsFriendAndFollowedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_friend, :boolean, default: false, after: :is_follower
    add_column :users, :followed, :boolean, default: false, after: :is_friend
  end
end
