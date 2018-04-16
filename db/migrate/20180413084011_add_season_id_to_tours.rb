class AddSeasonIdToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :season_id, :bigint, null: false
  end
end
