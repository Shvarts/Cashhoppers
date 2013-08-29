class AddCreatorIdToHopTasks < ActiveRecord::Migration
  def change
    add_column :hop_tasks, :creator_id, :integer
  end
end
