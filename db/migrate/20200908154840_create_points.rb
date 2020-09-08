class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
