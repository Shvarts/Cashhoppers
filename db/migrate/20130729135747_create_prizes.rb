class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.integer :cost
      t.integer :place
      t.references :user
      t.references :hop
    end
    add_index :prizes, :user_id
    add_index :prizes, :hop_id
  end
end