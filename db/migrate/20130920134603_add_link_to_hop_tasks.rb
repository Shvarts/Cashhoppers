class AddLinkToHopTasks < ActiveRecord::Migration
  def change
    add_column :hop_tasks, :link, :string
  end
end
