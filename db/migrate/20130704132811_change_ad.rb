class ChangeAd < ActiveRecord::Migration
  def up
    drop_table :ads
    rename_table :hop_ads, :ads
  end
end
