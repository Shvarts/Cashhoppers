Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  provider :facebook, '454724984623440', 'ec475b0c1066487fee83a88d8bf305fa'
  provider :twitter, 'kCODOcGjlpf6x03tcLHQ', 'c8tlMeqpmg2rkoRQygcsnKpa10sdvr7Tpt8tGosqd8'
end