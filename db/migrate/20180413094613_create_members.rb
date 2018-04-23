class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.decimal :total_score, precision: 3, scale: 1, null: false, default: 0
      t.decimal :points, precision: 3, scale: 1, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :scored_goals, null: false, default: 0
      t.integer :scored_penalties, null: false, default: 0
      t.integer :conceded_goals, null: false, default: 0
      t.integer :missed_penalties, null: false, default: 0
      t.integer :assists, null: false, default: 0
      t.integer :clean_sheets, null: false, default: 0
      t.integer :yellow_cards, null: false, default: 0
      t.integer :red_cards, null: false, default: 0
      t.integer :own_goals, null: false, default: 0
      t.belongs_to :player, null: false, index: true
      t.belongs_to :squad, null: false, index: true

      t.timestamps
    end
  end
end
