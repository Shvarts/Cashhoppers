class AddAsseptToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :accept, :boolean
  end
end
