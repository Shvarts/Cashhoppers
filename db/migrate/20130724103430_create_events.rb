class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :event_type
      t.integer :comment_id
      t.integer :like_id

      t.column :created_at, :datetime
    end
  end
end
