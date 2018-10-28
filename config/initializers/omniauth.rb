# frozen_string_literal: true

# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'production'
    provider :github, '39f29cf07824f818529f', '0498bdcc90d68eb82df99309b782308c89452623', scope: 'user,repo,gist'
  else
    provider :github, '87456d0e7e9326c3c28d', 'bedeb8b65e813c3da0663f09cfbe89efb7c2937a', scope: 'user,repo,gist'
  end
end
