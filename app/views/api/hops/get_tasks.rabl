collection :@hop_tasks

attributes :id, :price, :amt_paid, :bonus, :pts, :sponsor_id, :text, :hop_id

node :completed do |task|
   @user_hop_task = UserHopTask.where(user_id: @current_user.id, hop_task_id: task.id).first
   @user_hop_task ? true : false
end

node :logo do |task|
   task.logo.url if task.logo.present?
end

node :photo do |task|
   @user_hop_task.photo.url if @user_hop_task
end

node :comment do |task|
   @user_hop_task.comment if @user_hop_task
end
