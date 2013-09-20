require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.every("5m") do
  CashHoppers::Application::MESSAGES.delete_if{|message| message.created_at < (Time.now - 5.minutes) }
end

scheduler.every("1w") do
  #expired_sessions = CashHoppers::Application::SESSIONS.select{|session|
  #  session if session[:updated_at] < Time.now - 1.week
  #}
  expired_sessions = Session.where(:updated_at < Time.now - 1.week)
  expired_sessions.each do |session|
    #CashHoppers::Application::USERS.delete_if{|user| user.id < session[:user_id]}

    #CashHoppers::Application::SESSIONS.delete session
    expired_sessions.destroy
  end
end

scheduler.every("1h") do
  Hop.notificate_about_end
end

scheduler.every("30m") do
  Message.send_scheduled
end