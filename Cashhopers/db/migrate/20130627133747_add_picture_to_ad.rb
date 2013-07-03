class AddPictureToAd < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.has_attached_file :ad_picture
    end
  end

  def self.down
    drop_attached_file :ads, :ad_picture
  end
end
