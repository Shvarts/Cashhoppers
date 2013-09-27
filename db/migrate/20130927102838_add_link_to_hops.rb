class AddLinkToHops < ActiveRecord::Migration
  def change
    add_column :hops, :link, :string
  end
end
