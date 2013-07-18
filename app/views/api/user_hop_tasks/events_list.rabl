collection :@tasks

attributes :user_id, :hop_task_id, :created_at

node :hop_id do |task|
    task.hop_task.hop.id if (task.hop_task && task.hop_task.hop)
end

node :photo do |task|
    task.photo.url if task.photo
end


