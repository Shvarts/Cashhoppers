#if %w(test development).include?(Rails.env)
#  ActionMailer::Base.delivery_method = :test
#  ActionMailer::Base.sendmail_settings = {:location => '/usr/bin/fake_sendmail.sh'}
#else
#  ActionMailer::Base.delivery_method = :smtp
#
#end
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :charset => "utf-8"
ActionMailer::Base.smtp_settings = {
  :address => "smtp.cashhoppers.com",
  :port => 587,
  :authentication => "login",
  :domain               => 'cashhoppers.com',
  :host                 => 'http://perechin.net:3000',
  :user_name            => 'HopMaster@CASHHOPPERS.com',
  :password             => 'secret',
  :enable_starttls_auto => true
}
