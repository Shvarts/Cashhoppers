class ChangeFieldsTypeToBool < ActiveRecord::Migration
  def change
    change_column :hops, :close, :boolean, :default => false
    change_column :hops, :daily_hop, :boolean, :default => false
  end
end
