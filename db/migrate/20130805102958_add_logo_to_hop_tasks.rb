class AddLogoToHopTasks < ActiveRecord::Migration

    def self.up
      change_table :hop_tasks do |t|
        t.has_attached_file :logo
      end
    end

    def self.down
      drop_attached_file :hop_tasks, :logo
    end

end
