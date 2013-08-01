collection :@messages

attributes :id, :sender_id, :receiver_id, :text, :created_at

node :time_ago do |message|
    time_ago_in_words(message.created_at)
end

