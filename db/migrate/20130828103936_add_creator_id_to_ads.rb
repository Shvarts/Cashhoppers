class AddCreatorIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :creator_id, :integer
  end
end
