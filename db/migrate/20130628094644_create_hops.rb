class CreateHops < ActiveRecord::Migration
  def change
    create_table :hops do |t|
      t.string :name
      t.string :time_start
      t.string :time_end
      t.integer :producer_id
      t.string :producer_contact
      t.string :contact_phone
      t.string :contact_email
      t.string :hop_code
      t.string :hop_price
      t.string :jackpot
      t.string :hop_items

      t.timestamps
    end
  end
end
