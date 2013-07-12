class Friends < ActiveRecord::Migration
  def up
    create_table :friends_users, :id => false do |t|
      t.column :user_id, :integer
      t.column :friend_id, :integer
    end
  end

  def down
    drop_table :friends_users
  end
end
