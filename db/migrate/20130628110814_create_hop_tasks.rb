class CreateHopTasks < ActiveRecord::Migration
  def change
    create_table :hop_tasks do |t|
      t.references :hop
      t.text :text
      t.integer :sponsor_id
      t.string :price

      t.timestamps
    end
    add_index :hop_tasks, :hop_id
  end
end
