class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :init_price
      t.integer :actual_price
      t.string :avatar
      t.belongs_to :club, index: true
      t.belongs_to :team, index: true

      t.timestamps
    end
  end
end
