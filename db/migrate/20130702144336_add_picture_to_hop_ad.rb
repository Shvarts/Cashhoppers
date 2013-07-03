class AddPictureToHopAd < ActiveRecord::Migration
  def self.up
    change_table :hop_ads do |t|
      t.has_attached_file :hop_ad_picture
    end
  end

  def self.down
    drop_attached_file :hop_ads, :hop_ad_picture
  end
end
