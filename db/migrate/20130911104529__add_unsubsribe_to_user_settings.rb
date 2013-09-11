class AddUnsubsribeToUserSettings < ActiveRecord::Migration

  def change
    add_column :user_settings, :unsubscribe, :boolean
  end
end
