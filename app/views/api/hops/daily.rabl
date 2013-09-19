collection :@daily_hops
attributes :id,
           :name,
           :time_start,
           :time_end,
           :code,
           :price,
           :jackpot,
           :daily,
           :close,
           :event,
           :created_at,
           :updated_at

node :assigned do |hop|
   (hop.hoppers.include? @current_user) ? true : false
end

node :score do |hop|
   hop.score @current_user
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

node :ask_password do |hop|
    hop.is_password_disabled? @current_user
end