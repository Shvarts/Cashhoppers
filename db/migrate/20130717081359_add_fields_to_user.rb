class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :google, :string
  end
end
