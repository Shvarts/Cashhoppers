require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("15m") do
  Hop.close_old_hops
end