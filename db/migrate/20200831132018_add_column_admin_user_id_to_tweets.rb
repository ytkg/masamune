class AddColumnAdminUserIdToTweets < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :admin_user, foreign_key: true, after: :id
  end
end
