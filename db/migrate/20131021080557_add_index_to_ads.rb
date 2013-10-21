class AddIndexToAds < ActiveRecord::Migration
  def change
    add_column :ads, :hop_task_id, :integer

    add_index :ads, :hop_task_id
  end
end
