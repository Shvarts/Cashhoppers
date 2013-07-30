require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("10s") do
  Hop.close_old_hops
end