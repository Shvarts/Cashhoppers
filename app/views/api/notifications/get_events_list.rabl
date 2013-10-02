collection :@events

attributes :event_type, :created_at

child :comment do
    attributes :text
    node :user_hop_task_id do |comment|
        comment.commentable_id
    end
    child :user do
        attributes :id, :user_name
        node :first_name do |user|
            user.first_name || ''
        end
        node :last_name do |user|
            user.last_name || ''
        end
        node :avatar do |user|
            user.avatar.url
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
            user.avatar.url
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
            user.avatar.url
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
        user.avatar.url
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
    attributes :id, :name, :time_start, :time_end, :price, :daily, :event, :code, :link

    node :jackpot do |hop|
      prize = ((hop.jackpot == '0' || hop.jackpot == '') && hop.prizes.find_by_place('1'))? hop.prizes.find_by_place('1').cost : hop.jackpot
      (prize.to_s.match(/[a-zA-Z]/).nil? && !hop.jackpot.blank?)? ("$" + prize.to_s) : prize
    end

    node :logo do |hop|
       hop.logo.url
    end

    node :purchased do |hop|
        if hop.free?
            nil
        else
            hop.assigned? @current_user
        end
    end

    node :completed do |hop|
        completed = true
        hop.hop_tasks.each do |task|
            user_hop_task = UserHopTask.where(user_id: @current_user.id, hop_task_id: task.id).first
            unless user_hop_task
                completed = false
            end
        end
        completed
    end

    node :score do |hop|
       hop.score @current_user
    end
end

node :time_ago do |event|
    time_ago_in_words(event.created_at) + ' ago'
end





