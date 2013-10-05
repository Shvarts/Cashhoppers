class SetDefautValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :deleted, :boolean, :default => false
  end
end
