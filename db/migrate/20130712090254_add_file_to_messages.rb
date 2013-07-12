class AddFileToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :messages, :file
  end
end
