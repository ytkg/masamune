class AddColumnDescriptionToTwitterUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :twitter_users, :description, :text, after: :name
  end
end
