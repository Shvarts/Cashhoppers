class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.text :text
      t.column :created_at, :datetime
    end
    add_index :comments, :user_id
    add_index :comments, :commentable_id
  end
end
