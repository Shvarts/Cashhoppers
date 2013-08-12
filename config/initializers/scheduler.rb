require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("15m") do
  Hop.close_old_hops
end

scheduler.every("5m") do
  CashHoppers::Application::MESSAGES.delete_if{|message| message.created_at < (Time.now - 5.minutes) }
end

scheduler.every("1h") do
  expired_sessions = CashHoppers::Application::SESSIONS.select{|session|
    session if session[:updated_at] < Time.now - 1.week
  }
  expired_sessions.each do |session|
    CashHoppers::Application::USERS.delete_if{|user| user.id < session[:user_id]}
    CashHoppers::Application::SESSIONS.delete session
  end
end

scheduler.every("10s") do
  Notification.create(user_id: 1, friend_id: 2, event_type: 'Friend invite')
end