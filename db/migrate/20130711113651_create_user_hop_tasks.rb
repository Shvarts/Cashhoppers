class CreateUserHopTasks < ActiveRecord::Migration
  def change
    create_table :user_hop_tasks do |t|
      t.references :user
      t.references :hop_task

      t.timestamps
    end
    add_index :user_hop_tasks, :user_id
    add_index :user_hop_tasks, :hop_task_id
  end
end
