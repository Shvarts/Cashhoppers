class CreateEmailAlerts < ActiveRecord::Migration
  def change
    create_table :email_alerts do |t|
      t.text :text
      t.integer :sender_id
      t.integer :receiver_id
      t.datetime :schedule_date
      t.string :subject
      t.integer :template_id
      t.has_attached_file :file

      t.timestamps
    end
  end
end
