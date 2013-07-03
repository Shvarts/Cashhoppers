class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :advert_id
      t.string :advertiser_name
      t.integer :hop_id
      t.text :contact
      t.integer :phone
      t.string :email
      t.string :type_add
      t.integer :price
      t.integer :amd_paid
      t.string :link_to_ad

      t.timestamps
    end
  end
end
