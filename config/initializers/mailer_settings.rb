if %w(test development).include?(Rails.env)
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.sendmail_settings = {:location => '/usr/bin/fake_sendmail.sh'}
else
  ActionMailer::Base.delivery_method = :smtp
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
