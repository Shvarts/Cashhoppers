collection :@messages
attributes :sender_id, :text, :created_at

node :time_ago do |message|
    time_ago_in_words(message.created_at)
end

node :friendship_status do |message|
    friendship
    if message.sender_id == @current_user.id
        friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, message.receiver_id)
    else
        friendship = Friendship.find_by_user_id_and_friend_id(@current_user.id, message.sender_id)
    end
    friendship.status
end