class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :text
      t.integer :author_id
      t.string :receiver_id

      t.timestamps
    end
  end
end
