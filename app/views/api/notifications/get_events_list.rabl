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
        node :friendship_status do |user|
            friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, user.id)
            friendship.status if friendship
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
        node :friendship_status do |user|
            friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, user.id)
            friendship.status if friendship
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
        node :friendship_status do |user|
            friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, user.id)
            friendship.status if friendship
        end
    end
end

child :friend do
    attributes :id, :last_name, :first_name, :user_name
    node :avatar do |user|
        user.avatar.url if user.avatar_file_size
    end
    node :friendship_status do |user|
        friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, user.id)
        friendship.status if friendship
    end
end

child :message do
    attributes :text
end

child :hop do
    attributes :name, :time_start, :time_end, :price, :daily, :event
end

node :time_ago do |event|
    time_ago_in_words(event.created_at) + ' ago'
end





