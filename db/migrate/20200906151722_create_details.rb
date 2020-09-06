class CreateDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :details do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.text :value

      t.timestamps
    end
  end
end
