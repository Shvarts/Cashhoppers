object :@user_hop_task

attributes :user_id, :hop_task_id, :created_at, :comment

node :hop_id do |task|
    task.hop_task.hop.id if (task.hop_task && task.hop_task.hop)
end

node :hop_task_text do |task|
    task.hop_task.text if (task.hop_task)
end

node :photo do |task|
    task.photo.url if task.photo
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

node :user_first_name do |task|
   task.user.first_name
end

node :user_last_name do |task|
   task.user.last_name
end

node :user_user_name do |task|
   task.user.user_name
end

node :user_avatar do |task|
   task.user.avatar.url
end

node :likers do |task|
   task.likes.map do |like|
    name = ''
    name += like.user.first_name + ' ' if like.user.first_name
    name += like.user.last_name if like.user.last_name
    name
   end
end

node :time_ago do |task|
    time_ago_in_words(task.created_at)
end

