Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :facebook, '454724984623440', 'ec475b0c1066487fee83a88d8bf305fa'
    provider :twitter, 'kCODOcGjlpf6x03tcLHQ', 'c8tlMeqpmg2rkoRQygcsnKpa10sdvr7Tpt8tGosqd8'
    provider :google, '1035528016554.apps.googleusercontent.com', 'mWAsXLX0xuY037Q_2FKZuTMc'
  elsif Rails.env.production?
    provider :twitter, 'xUMspgA20dOVm7USc3tqKA', '2pm7XHK3dBcp7nIYO5NpESEtBf3XlAh37lwwMU414'
    provider :facebook, '264599550349996', 'a05b733f8e765f6355d4a261afa876ed'
  end
end