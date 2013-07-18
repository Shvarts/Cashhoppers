if %w(test development).include?(Rails.env)
  ActionMailer::Base.delivery_method = :test
else
  ActionMailer::Base.delivery_method = :sendmail
end

  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.default :charset => "utf-8"
  ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
     #   :domain => "localhost",
      :authentication => "plain",
      :domain               => 'perechin.net',
      :user_name            => 'mail',
      :password             => 'pass',
      :enable_starttls_auto => true
  }
#end
