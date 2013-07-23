class AddCommentToUserHopTask < ActiveRecord::Migration
  def change
    add_column :user_hop_tasks, :comment, :string
  end
end
