class AddAmtToAds < ActiveRecord::Migration
  def change
    add_column :ads, :amt, :integer
  end
end
