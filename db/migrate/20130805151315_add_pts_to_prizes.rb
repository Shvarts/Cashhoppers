class AddPtsToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :pts, :integer
  end
end
