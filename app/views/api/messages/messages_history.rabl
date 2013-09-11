collection :@messages

attributes :id, :sender_id, :receiver_id, :text, :created_at

node :time_ago do |message|
    time_ago_in_words(message.created_at)
end

node :friend_avatar do |message|
    if message.sender_id == @current_user.id
        message.receiver.avatar.url if message.receiver
    else
        message.sender.avatar.url if message.sender
    end
end

node :friend_first_name do |message|
    if message.sender_id == @current_user.id
        message.receiver.first_name if message.receiver
    else
        message.sender.first_name if message.sender
    end
end

node :friend_last_name do |message|
    if message.sender_id == @current_user.id
        message.receiver.last_name if message.receiver
    else
        message.sender.last_name if message.sender
    end
end

