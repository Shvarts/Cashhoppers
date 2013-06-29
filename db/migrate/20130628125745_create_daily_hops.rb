class CreateDailyHops < ActiveRecord::Migration
  def change
    create_table :daily_hops do |t|
      t.string :name
      t.integer :user_id
      t.text :text_for_item
      t.string :winner
      t.string :points
      t.string :share_point
      t.string :jackpot
      t.string :users

      t.timestamps
    end
  end
end
