Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  if Rails.env.development?

    provider :facebook, '454724984623440', 'ec475b0c1066487fee83a88d8bf305fa'
    provider :twitter, 'kCODOcGjlpf6x03tcLHQ', 'c8tlMeqpmg2rkoRQygcsnKpa10sdvr7Tpt8tGosqd8'
    provider :google, '1035528016554.apps.googleusercontent.com', 'mWAsXLX0xuY037Q_2FKZuTMc'
  elsif Rails.env.production?
    provider :facebook, '637058249649507', '103086b804f6bc22b0710635f8e5e7af'
    provider :twitter, 'OVq7xVCNgJ5FAXkeramRDA', '3lbBWHxzMrUgZQ86NxmbhQDAclvakWsGTDuXdcQHbY'
    provider :google, '247978655886.apps.googleusercontent.com', 'dnNCYcmHcwg22yf6V3AaulIl'
  end
end
