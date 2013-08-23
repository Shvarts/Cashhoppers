collection :@prizes
attributes :cost, :place

node :title do |prize|
   prize.place
end