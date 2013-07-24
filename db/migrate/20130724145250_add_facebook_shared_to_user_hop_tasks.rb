class AddFacebookSharedToUserHopTasks < ActiveRecord::Migration
  def change
    add_column :user_hop_tasks, :facebook_shared, :boolean
    add_column :user_hop_tasks, :twitter_shared, :boolean
    add_column :user_hop_tasks, :google_shared, :boolean
  end
end
