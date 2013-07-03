class AddBonusToHopTask < ActiveRecord::Migration
  def change
    add_column :hop_tasks, :pts, :integer
    add_column :hop_tasks, :bonus, :integer
  end
end
