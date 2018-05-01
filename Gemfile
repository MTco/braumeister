source 'https://rubygems.org'
ruby '2.5.1'

gem 'compass-rails', '~> 3.0.2'
gem 'dalli', '~> 2.7.8'
gem 'font-awesome-sass', '~> 5.0'
gem 'kaminari-actionview', '~> 1.1'
gem 'kaminari-mongoid', '~> 1.0'
gem 'mongoid', '~> 6.4'
gem 'puma', '~> 3.11'
gem 'rails', '5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'text', '~> 1.3.0'
gem 'uglifier', '~> 4.1'

group :development do
  gem 'foreman', '~> 0.60'
end

group :development, :test do
  gem 'codeclimate-test-reporter', '~> 1.0'
  gem 'rspec-rails', '~> 3.7'
end

group :production do
  gem 'skylight', '~> 2.0'     # Before newrelic_rpm for correct reporting
  gem 'newrelic_rpm', '~> 5.1'
  gem 'rails_12factor', '~> 0.0.2'
  gem 'rollbar', '~> 2.15'
end

group :test do
  gem 'mocha', '~> 1.5.0', require: 'mocha/api'
end
