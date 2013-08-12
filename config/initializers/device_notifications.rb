CashHoppers::Application::IOS_PUSHER = Grocer.pusher(
  certificate: "#{Rails.root}/app/assets/certificates/ck.pem",      # required
  passphrase:  "123456",                 # optional
  gateway:     "gateway.push.apple.com", # optional; See note below.
  port:        2195,                     # optional
  retries:     3                         # optional
)

