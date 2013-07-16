class AddSendAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :send_at, :datetime
    remove_column :messages, :email_text
    rename_column :messages, :author_id, :sender_id
  end
end
