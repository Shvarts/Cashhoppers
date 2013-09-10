class AddZipToHops < ActiveRecord::Migration
  def change
    add_column :hops, :zip, :string
  end
end
