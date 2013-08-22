class ChangeDataTypeForHopPrice < ActiveRecord::Migration
  def change
    change_column :hops, :price, :integer
  end
end
