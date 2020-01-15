class CreateTrends < ActiveRecord::Migration[6.0]
  def change
    create_table :trends do |t|
      t.date :result_date
      t.string :name
      t.text :url
      t.integer :tweet_volume

      t.timestamps
    end
  end
end
