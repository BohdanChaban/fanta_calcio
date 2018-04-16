class CreateSquads < ActiveRecord::Migration[5.1]
  def change
    create_table :squads do |t|
      t.belongs_to :team, null: false, index: true
      t.belongs_to :tour, null: false

      t.timestamps
    end
  end
end
