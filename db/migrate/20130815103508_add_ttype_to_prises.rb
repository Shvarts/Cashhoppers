class AddTtypeToPrises < ActiveRecord::Migration
  def change
    add_column :prizes, :prize_type, :string
  end
end
