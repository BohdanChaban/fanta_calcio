class CreateClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :clubs do |t|
      t.string :name, null: false
      t.string :logo
      t.integer :points, default: 0
      t.integer :position
      t.integer :goals_diff, default: 0
      t.integer :win, default: 0
      t.integer :draw, default: 0
      t.integer :lose, default: 0

      t.timestamps
    end
  end
end
