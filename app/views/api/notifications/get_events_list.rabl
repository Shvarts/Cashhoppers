collection :@events

attributes :event_type, :created_at

node :comment_text do |event|
   event.comment.text if event.event_type == 'Comment'
end

node :user_id do |event|
   event.user.id
end

node :user_first_name do |event|
   event.user.first_name
end

node :user_last_name do |event|
   event.user.last_name
end

node :user_user_name do |event|
   event.user.user_name
end

node :user_avatar do |event|
   event.user.avatar.url
end

node :user_hop_task_id do |event|
   if event.event_type == 'Comment'
      event.comment.commentable_id
   elsif event.event_type == 'Like'
      event.like.target_object_id
   end
end
