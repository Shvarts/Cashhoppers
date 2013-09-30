collection :@daily_hops
attributes :id,
           :name,
           :time_start,
           :time_end,
           :code,
           :price,
           :daily,
           :close,
           :event,
           :link,
           :created_at,
           :updated_at

node :jackpot do |hop|

   (hop.jackpot == '0')? hop.prizes.find_by_place('1').cost : hop.jackpot

end


node :time_start do |hop|
   hop.time_start.strftime("%Y-%m-%dT%H:%M:%SZ")
end

node :time_end do |hop|
    hop.time_end.strftime("%Y-%m-%dT%H:%M:%SZ")
end

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