class CreateHopTasks < ActiveRecord::Migration
  def change
    create_table :hop_tasks do |t|
      t.references :hop
      t.text :text
      t.integer :sponsor_id
      t.string :price
      t.integer :pts
      t.integer :bonus
      t.integer :amt_paid

      t.timestamps
    end
    add_index :hop_tasks, :hop_id
  end
end
