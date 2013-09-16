collection :@hops

node :id do |hop|
    hop["id"]
end

node :name do |hop|
    hop["name"]
end

node :time_start do |hop|
    hop["time_start"]
end

node :time_end do |hop|
    hop["time_end"]
end

node :code do |hop|
    hop["code"]
end

node :price do |hop|
    hop["price"]
end

node :jackpot do |hop|
    hop["jackpot"]
end

node :daily do |hop|
    hop["daily"]
end

node :close do |hop|
    hop["close"]
end

node :event do |hop|
    hop["event"]
end

node :created_at do |hop|
    hop["created_at"]
end

node :zip do |hop|
    hop["zip"]
end

node :assigned do |hop|
   hop["hoppers_hops_id"] == nil ? false : true
end

node :score do |hop|
   hop["score"]
end

node :logo do |hop|
   @hop = Hop.new(id: hop['id'], logo_file_name: hop['logo_file_name'])
   @hop.logo.url
end

node :purchased do |hop|
    if hop["price"].blank? || hop["price"] == 0
        nil
    else
        hop["hoppers_hops_id"] == nil ? false : true
    end
end

node :completed do |hop|
    if hop["hop_tasks_count"] == hop["user_hop_tasks_count"]
        true
    else
        false
    end
end

node :ask_password do |hop|
    hop["ask_password"]
end
