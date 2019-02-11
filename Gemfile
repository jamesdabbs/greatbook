source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'rails', '~> 5.2.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry-rails'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

group :development do
  gem 'guard-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'annotate'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hashie'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara', '>= 2.15', require: false
  gem 'chromedriver-helper', require: false
  gem 'selenium-webdriver', require: false
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
