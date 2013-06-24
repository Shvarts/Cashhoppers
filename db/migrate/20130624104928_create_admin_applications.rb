class CreateAdminApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.text :description
      t.string :api_key

      t.timestamps
    end
  end
end
