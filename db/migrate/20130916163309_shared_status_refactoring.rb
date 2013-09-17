class SharedStatusRefactoring < ActiveRecord::Migration
  def change
    remove_column :user_hop_tasks, :facebook_shared
    remove_column :user_hop_tasks, :twitter_shared
    remove_column :user_hop_tasks, :google_shared
    add_column :user_hop_tasks, :shared, :boolean
    UserHopTask.all.each do |task|
      task.update_attribute :shared, false
    end
  end
end
