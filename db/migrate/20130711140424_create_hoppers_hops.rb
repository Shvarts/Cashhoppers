class CreateHoppersHops < ActiveRecord::Migration
  def change
    create_table :hoppers_hops do |t|
      t.integer :user_id
      t.integer :hop_id

      t.timestamps
    end
  end
end
