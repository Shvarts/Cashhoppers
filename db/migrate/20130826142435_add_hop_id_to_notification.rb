class AddHopIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :hop_id, :integer
  end
end
