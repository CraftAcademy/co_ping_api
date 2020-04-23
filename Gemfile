source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors', require: 'rack/cors'
gem 'devise_token_auth'
gem 'active_model_serializers', '~> 0.10.0'
gem 'rest-client'

group :development, :test do
  gem 'pry-byebug'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'coveralls', require: false
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
