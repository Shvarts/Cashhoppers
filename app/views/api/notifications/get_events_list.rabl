collection :@events

attributes :event_type, :created_at

child :comment do
    attributes :text, :user_id, :commentable_id => :user_hop_task_id
end

child :like do
    attributes  :user_id, :target_object_id => :user_hop_task_id
end

child :prize do
    attributes :cost, :place, :user_id, :hop_id
end

child :friend do
    attributes :id, :last_name, :first_name, :user_name
    node :avatar do |user|
        user.avatar.url if user.avatar_file_size
    end

    node :friends_count do |user|
        user.friends.count
    end
end

node :time_ago do |event|
    time_ago_in_words(event.created_at)
end





