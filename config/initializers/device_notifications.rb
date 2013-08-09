CashHoppers::Application::IOS_PUSHER = Grocer.pusher(
 # certificate: "/path/to/cert.pem",      # required
  passphrase:  "",                       # optional
  gateway:     "gateway.push.apple.com", # optional; See note below.
  port:        2195,                     # optional
  retries:     3                         # optional
)

