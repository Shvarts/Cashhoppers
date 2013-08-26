class CreateAndroidLogs < ActiveRecord::Migration
  def change
    create_table :android_logs do |t|
      t.text :text

      t.timestamps
    end
  end
end
