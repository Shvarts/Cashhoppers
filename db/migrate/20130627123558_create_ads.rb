class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :advertizer_id
      t.integer :hop_id
      t.string :ad_type
      t.integer :price
      t.integer :amt_paid
      t.string :link
      t.has_attached_file :picture

      t.timestamps
    end
  end
end
