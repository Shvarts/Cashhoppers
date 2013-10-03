collection :@prizes
attributes :cost, :place

node :title do |prize|
   prize.place
end

node :cost do |prize|
   (prize.cost.to_s.match(/(\$)|([a-zA-Z])/).nil? && !prize.cost.blank?)? ("$" + prize.cost.to_s) : prize.cost
end