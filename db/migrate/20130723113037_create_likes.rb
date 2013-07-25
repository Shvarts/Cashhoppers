class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :target_object_id
      t.string :target_object
      t.column :created_at, :datetime
    end
  end
end
