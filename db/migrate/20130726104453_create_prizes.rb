class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :hop_name
      t.integer :jackpot
      t.integer :place
      t.references :user
      t.references :hop

      t.timestamps
    end
    add_index :prizes, :user_id
    add_index :prizes, :hop_id
  end
end
