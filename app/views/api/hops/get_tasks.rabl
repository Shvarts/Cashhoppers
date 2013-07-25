collection :@hop_tasks

attributes :id, :price, :amt, :bonus, :pts, :sponsor_id, :text, :hop_id

node :picture do |task|
   task.hop_picture.url if task.hop_picture.present?
end

node :completed do |task|
   UserHopTask.where(user_id: @current_user.id, hop_task_id: task.id).first ? true : false
end
