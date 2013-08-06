CashHoppers::Application::APPLICATIONS = Application.all












#CashHoppers::Application::APPLICATIONS.select{|message|
#  message if (message.created_at > sync_time &&
#    ids.include?(message.sender_id)&&
#    ids.include?(message.receiver_id)
#  )}