class RemoveHopAds < ActiveRecord::Migration
  def up
    drop_table :hop_ads
  end

  def down
    create_table :hop_ads do |t|
      t.string :ad_name
      t.string :contact
      t.string :email
      t.string :phone
      t.string :price
      t.string :ad_type
      t.string :link_to_ad
      t.integer :hop_id
      t.integer :sponsor_id
      t.has_attached_file :hop_ad_picture
      t.timestamps
    end
  end
end
