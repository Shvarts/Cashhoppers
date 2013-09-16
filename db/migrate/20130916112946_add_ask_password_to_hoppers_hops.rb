class AddAskPasswordToHoppersHops < ActiveRecord::Migration
  def change
    add_column :hoppers_hops, :ask_password, :boolean
    ActiveRecord::Base.connection().execute("UPDATE hoppers_hops SET ask_password = 1")
    ActiveRecord::Base.connection.close
  end
end
