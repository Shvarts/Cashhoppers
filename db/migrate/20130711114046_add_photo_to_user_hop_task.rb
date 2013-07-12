class AddPhotoToUserHopTask < ActiveRecord::Migration
  def self.up
    change_table :user_hop_tasks do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :user_hop_tasks, :photo
  end
end
