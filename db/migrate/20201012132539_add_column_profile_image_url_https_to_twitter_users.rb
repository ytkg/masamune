class AddColumnProfileImageUrlHttpsToTwitterUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :twitter_users, :profile_image_url_https, :text, after: :description
  end
end
