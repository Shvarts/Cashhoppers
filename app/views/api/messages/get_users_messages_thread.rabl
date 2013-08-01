collection :@friends

node :friend_id do |friend|
   friend.id
end

node :friend_avatar do |friend|
   friend.avatar.url if friend.avatar_file_size
end

node :friend_first_name do |friend|
   friend.first_name
end

node :friend_last_name do |friend|
   friend.last_name
end

node :friend_user_name do |friend|
   friend.user_name
end

node :last_message_id do |friend|
   @message = Message.where(sender_id: [friend.id, @current_user.id], receiver_id: [@current_user.id, friend.id]).last
   @message ? @message.id : nil
end

node :last_message_text do |friend|
   @message.text if @message
end

node :time_ago do |message|
    time_ago_in_words(@message.created_at) if @message
end

node :last_message_created_at do |friend|
   @message.created_at if @message
end



