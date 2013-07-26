collection :@hop_tasks

attributes :id, :price, :amt, :bonus, :pts, :sponsor_id, :text, :hop_id

node :completed do |task|
   UserHopTask.where(user_id: @current_user.id, hop_task_id: task.id).first ? true : false
end
