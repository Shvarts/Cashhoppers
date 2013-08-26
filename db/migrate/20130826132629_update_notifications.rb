class UpdateNotifications < ActiveRecord::Migration
  def change
    remove_column :user_settings, :friend_invite_accept
    remove_column :user_settings, :end_of_hop
    remove_column :user_settings, :comment
    remove_column :user_settings, :like

    add_column :user_settings, :comment_or_like, :boolean

    add_column :hops, :notificated_about_end, :boolean
    Hop.all.each do |hop|
      hop.update_attribute :notificated_about_end, false
    end
  end
end
