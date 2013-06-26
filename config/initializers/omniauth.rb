Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  if Rails.env.development?
    provider :facebook, '454724984623440', 'ec475b0c1066487fee83a88d8bf305fa'
    provider :twitter, 'kCODOcGjlpf6x03tcLHQ', 'c8tlMeqpmg2rkoRQygcsnKpa10sdvr7Tpt8tGosqd8'
  elsif Rails.env.production?
    provider :twitter, 'xUMspgA20dOVm7USc3tqKA', '2pm7XHK3dBcp7nIYO5NpESEtBf3XlAh37lwwMU414'
    provider :facebook, '264599550349996', 'a05b733f8e765f6355d4a261afa876ed'
  end
end