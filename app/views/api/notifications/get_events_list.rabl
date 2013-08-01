collection :@events

attributes :event_type, :created_at

child :comment do
    attributes :text
    node :user_hop_task_id do |comment|
        comment.commentable_id
    end
    child :user do
        attributes :id, :last_name, :first_name, :user_name
        node :avatar do |user|
            user.avatar.url if user.avatar_file_size
        end
    end
end

child :like do
    node :user_hop_task_id do |comment|
        comment.target_object_id
    end
    child :user do
        attributes :id, :last_name, :first_name, :user_name
        node :avatar do |user|
            user.avatar.url if user.avatar_file_size
        end
    end
end

child :prize do
    attributes :cost, :place, :hop_id
    child :user do
        attributes :id, :last_name, :first_name, :user_name
        node :avatar do |user|
            user.avatar.url if user.avatar_file_size
        end
    end
end

child :friend do
    attributes :id, :last_name, :first_name, :user_name
    node :avatar do |user|
        user.avatar.url if user.avatar_file_size
    end
end

node :time_ago do |event|
    time_ago_in_words(event.created_at)
end





