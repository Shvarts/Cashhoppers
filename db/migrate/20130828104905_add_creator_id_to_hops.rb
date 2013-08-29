class AddCreatorIdToHops < ActiveRecord::Migration
  def change
    add_column :hops, :creator_id, :integer
  end
end
