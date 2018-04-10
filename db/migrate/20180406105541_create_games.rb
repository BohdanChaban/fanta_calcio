class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.datetime :start_time, null: false
      t.bigint :tour_id, null: false
      t.bigint :host_id, null: false
      t.bigint :guest_id, null: false

      t.timestamps
    end
  end
end
