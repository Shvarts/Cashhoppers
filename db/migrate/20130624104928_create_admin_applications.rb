class CreateAdminApplications < ActiveRecord::Migration
  def change
    create_table :admin_applications do |t|
      t.string :name
      t.text :description
      t.string :api_key

      t.timestamps
    end
  end
end
