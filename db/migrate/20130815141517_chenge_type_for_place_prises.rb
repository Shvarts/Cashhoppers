class ChengeTypeForPlacePrises < ActiveRecord::Migration
  def change
    change_column :prizes, :place, :string
  end
end
