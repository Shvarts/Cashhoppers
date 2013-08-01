object :@comments

attributes :user_id, :text, :created_at

node :time_ago do |comment|
    time_ago_in_words(comment.created_at)
end


