object :@hop
attributes :id,
           :name,
           :time_start,
           :time_end,
           :code,
           :price,
           :daily,
           :close,
           :link,
           :event,
           :created_at,
           :updated_at

node :jackpot do |hop|


   prize =  ((hop.jackpot=='0'||hop.jackpot == '') && hop.prizes.find_by_place('1'))? hop.prizes.find_by_place('1').cost : hop.jackpot

    (prize.to_s.match(/(\$)|([a-zA-Z])/).nil? && !prize.blank?)? ("$" + prize.to_s) : prize
end

node :time_start do |hop|
   hop.time_start.strftime("%Y-%m-%dT%H:%M:%SZ")
end

node :time_end do |hop|
    hop.time_end.strftime("%Y-%m-%dT%H:%M:%SZ")
end

node :assigned do |hop|

   @current_user.games.include? hop
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
        @current_user.games.include? hop
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