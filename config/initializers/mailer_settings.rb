ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "perechin.net",
  :authentication => "plain",
  :user_name => "viktor.danch@gmail.com",
  :password => "a22111989a",
  :enable_starttls_auto => true
}
