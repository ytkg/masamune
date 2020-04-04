class AddColumnNameAndScreenNameAndProfileImageUrlHttpsToUserSummaries < ActiveRecord::Migration[6.0]
  def change
    add_column :user_summaries, :name, :string, after: :result_date
    add_column :user_summaries, :screen_name, :string, after: :name
    add_column :user_summaries, :profile_image_url_https, :text, after: :screen_name
  end
end
