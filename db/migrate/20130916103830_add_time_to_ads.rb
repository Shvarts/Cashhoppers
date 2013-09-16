class AddTimeToAds < ActiveRecord::Migration
  def change
    add_column :ads, :time_start, :datetime
    add_column :ads, :time_end, :datetime
  end
end
