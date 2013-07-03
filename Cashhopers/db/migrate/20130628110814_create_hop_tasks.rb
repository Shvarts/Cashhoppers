class CreateHopTasks < ActiveRecord::Migration
  def change
    create_table :hop_tasks do |t|
      t.references :hop
      t.text :text_for_hop
      t.integer :sponsor_id
      t.string :hop_task_price

      t.timestamps
    end
    add_index :hop_tasks, :hop_id
  end
end
