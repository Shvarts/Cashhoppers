class AddFrogLegsToUser < ActiveRecord::Migration
  def change
    add_column :users, :frog_legs, :integer
    add_column :user_settings, :ad_enable, :boolean
    ############# FIX 
    #User.all.each{|user|
      #user.update_attribute :frog_legs, 0
      #user.user_settings.update_attribute :ad_enable, true if user.user_settings
    #}
  end
end
