class AddPhotoToHopTask < ActiveRecord::Migration
  def self.up
    change_table :hop_tasks do |t|
      t.has_attached_file :hop_picture
    end
  end

  def self.down
    drop_attached_file :hop_tasks, :hop_picture
  end
end
