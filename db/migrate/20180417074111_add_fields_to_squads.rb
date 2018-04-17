class AddFieldsToSquads < ActiveRecord::Migration[5.1]
  def change
    add_column :squads, :total_score, :decimal, precision: 3, scale: 1, null: false, default: 0
    add_column :squads, :goals, :integer, null: false, default: 0
    add_column :squads, :points, :integer, null: false, default: 0
  end
end
