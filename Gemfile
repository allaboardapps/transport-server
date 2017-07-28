source "https://rubygems.org"

ruby "2.4.1"
gem "rails", "5.1.2"

# global
# gem install bundler
# gem install foreman

gem "active_model_serializers", "0.10.5"
gem "activeadmin", "1.0.0"
gem "faker", "1.7.3"
gem "figaro", "1.1.1"
gem "pg", "0.20.0"
gem "postmark-rails", "0.15.0"
gem "puma", "3.8.2"
gem "pundit", "1.1.0"
gem "rollbar", "2.14.1"
gem "sass-rails", "5.0.6"
gem "settingslogic", "2.0.9"
gem "sidekiq", "5.0.0"
gem "uglifier", "3.2.0"

group :production do
  gem "scout_apm", "2.1.24"
end

group :development, :test do
  gem "brakeman", "3.6.1", require: false
  gem "bundler-audit", "0.5.0", require: false
  gem "byebug", "9.0.6"
  gem "factory_girl_rails", "4.8.0"
  gem "hakiri", "0.7.2", require: false
  gem "pry-byebug", "3.4.2"
  gem "pry-rails", "0.3.6"
  gem "pry-remote", "0.1.8"
  gem "rails_db", "1.5.0"
  gem "rubocop", "0.48.1"
end

group :development do
  gem "letter_opener_web", "1.3.1"
  gem "listen", "3.1.5"
  gem "web-console", "3.5.0"
  gem "yard", "0.9.9"
end

group :test do
  gem "pry-doc", "0.10.0"
  gem "pundit-matchers", "1.2.3"
  gem "rspec-instafail", "1.0.0", require: false
  gem "rspec-json_expectations", "2.1.0"
  gem "rspec-rails", "3.5.2"
  gem "rspec-retry", "0.5.3"
  gem "rspec-sidekiq", "3.0.1"
  gem "rubocop-rspec", "1.15.0"
  gem "shoulda-matchers", "3.1.1"
end
