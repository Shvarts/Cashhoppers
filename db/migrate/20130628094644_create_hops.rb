class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.string :name
      t.datetime :time_start
      t.datetime :time_end
      t.integer :producer_id
      t.string :code
      t.string :price
      t.integer :jackpot
      t.boolean :daily
      t.boolean :close
      t.string :event
      t.has_attached_file :logo

      t.timestamps
    end
  end
end
