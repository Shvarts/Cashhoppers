class ChengePrizesCost < ActiveRecord::Migration
  def change
    change_column :prizes, :cost, :string
  end
end
