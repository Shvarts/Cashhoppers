class AddEmailToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :email, :boolean
    add_column :messages, :template, :string
    add_column :messages, :email_author, :string
    add_column :messages, :email_text, :text
  end
end
