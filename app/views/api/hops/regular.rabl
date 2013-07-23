collection :@hops
attributes   :id,
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
