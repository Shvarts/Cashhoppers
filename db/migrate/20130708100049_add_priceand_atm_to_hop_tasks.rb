class AddPriceandAtmToHopTasks < ActiveRecord::Migration
  def change

    add_column :hop_tasks, :amt, :integer
  end
end
