class AddMessageAndNewHopAndHopAboutToEndToUserSettings < ActiveRecord::Migration
  def change
    add_column :user_settings, :message, :boolean
    add_column :user_settings, :new_hop, :boolean
    add_column :user_settings, :hop_about_to_end, :boolean
    UserSettings.all.each do |us|
      us.update_attributes message: true, new_hop: true, hop_about_to_end: true
    end
  end
end
