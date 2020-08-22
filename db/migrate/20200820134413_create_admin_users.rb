class CreateAdminUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_users, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY'
      t.string :screen_name, null: false
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :token, null: false
      t.string :secret, null: false

      t.timestamps
    end
  end
end
