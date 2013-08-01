collection :@tasks

attributes :id, :user_id, :hop_task_id, :created_at, :comment

node :hop_task_text do |task|
    task.hop_task.text if (task.hop_task)
end

node :hop_id do |task|
    task.hop_task.hop.id if (task.hop_task && task.hop_task.hop)
end

node :photo do |task|
    task.photo.url(:small) if task.photo
end

node :likes_count do |task|
   Like.where(target_object_id: task.id, target_object: 'UserHopTask').count
end

node :comments_count do |task|
   Comment.where(commentable_id: task.id).count
end

node :liked do |task|
   Like.where(target_object_id: task.id, target_object: 'UserHopTask', user_id: @current_user.id).first ? true : false
end

node :time_ago do |task|
    time_ago_in_words(task.created_at)
end

