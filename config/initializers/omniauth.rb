Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  if Rails.env.development?
    provider :facebook, '637058249649507', '103086b804f6bc22b0710635f8e5e7af'
    provider :twitter, 'OVq7xVCNgJ5FAXkeramRDA', '3lbBWHxzMrUgZQ86NxmbhQDAclvakWsGTDuXdcQHbY'
    provider :google, '247978655886.apps.googleusercontent.com', 'dnNCYcmHcwg22yf6V3AaulIl'
  elsif Rails.env.production?
    provider :facebook, '637058249649507', '103086b804f6bc22b0710635f8e5e7af'
    provider :twitter, 'OVq7xVCNgJ5FAXkeramRDA', '3lbBWHxzMrUgZQ86NxmbhQDAclvakWsGTDuXdcQHbY'
    provider :google, '247978655886.apps.googleusercontent.com', 'dnNCYcmHcwg22yf6V3AaulIl'
  end
end