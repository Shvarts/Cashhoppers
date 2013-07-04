class ChangeCloseAndDailyHopToBoolOnHop < ActiveRecord::Migration
  def up
    change_column :hops, :close, :boolean, :default => false
    change_column :hops, :daily_hop, :boolean, :default => false
  end
end
