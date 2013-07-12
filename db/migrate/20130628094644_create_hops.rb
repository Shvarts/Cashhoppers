class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.string :name
      t.string :time_start
      t.string :time_end
      t.integer :producer_id
      t.string :code
      t.string :price
      t.integer :jackpot
      t.boolean :daily_hop
      t.boolean :close
      t.string :event

      t.timestamps
    end
  end
end
