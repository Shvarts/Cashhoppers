class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :friend_invite
      t.boolean :friend_invite_accept
      t.boolean :end_of_hop
      t.boolean :comment
      t.boolean :like
      t.references :user
    end
  end
end
