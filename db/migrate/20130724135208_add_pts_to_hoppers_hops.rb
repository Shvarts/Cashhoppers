class AddPtsToHoppersHops < ActiveRecord::Migration
  def change
    add_column :hoppers_hops, :pts, :integer
  end
end
