begin
  CashHoppers::Application::APPLICATIONS = Application.all
rescue Exception => e
  puts e
end

