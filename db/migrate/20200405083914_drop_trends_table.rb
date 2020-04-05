class DropTrendsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :trends
  end
end
