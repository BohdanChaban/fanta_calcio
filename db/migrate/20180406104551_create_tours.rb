class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.integer :number, null: false
      t.date :base_date, null: false

      t.timestamps
    end
  end
end
