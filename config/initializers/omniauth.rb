Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :gplus, ENV['GPLUS_KEY'], ENV['GPLUS_SECRET'], scope: 'userinfo.email, userinfo.profile'
end
