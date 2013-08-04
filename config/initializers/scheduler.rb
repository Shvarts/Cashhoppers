require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("15m") do
  Hop.close_old_hops
end

scheduler.every("5m") do
  CashHoppers::Application::MY_GLOBAL_ARRAY.delete_if{|message| massage.created_at < (Time.now - 5.minutes) }
end