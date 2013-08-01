collection :@messages

node :last_message_text do |message|
   message['text']
end

node :last_message_id do |message|
   message['id']
end

node :last_message_created_at do |message|
   message['created_at']
end

node :last_message_sender_id do |message|
   message['sender_id']
end

node :last_message_receiver_id do |message|
   message['receiver_id']
end

node :friend_id do |message|
   message['friend_id']
end

node :friend_first_name do |message|
   message['friend_first_name']
end

node :friend_last_name do |message|
   message['friend_last_name']
end

node :friend_user_name do |message|
   message['friend_user_name']
end

node :friend_avatar_file_name do |message|
   user = User.new(id: message['friend_id'], avatar_file_name: message['friend_avatar_file_name'])
   user.avatar.url
end

node :time_ago do |message|
    time_ago_in_words(message['created_at'])
end