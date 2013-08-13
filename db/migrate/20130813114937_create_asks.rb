class CreateAsks < ActiveRecord::Migration
  def change
    create_table :asks do |t|
      t.string :ask
      t.text :answer

      t.timestamps
    end
  end
end
