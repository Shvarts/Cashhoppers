class ChangeDataTypeForJackpot < ActiveRecord::Migration
  def change
    change_column :hops, :jackpot, :string
  end
end
