source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0.beta1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'jbuilder', '~> 2.5'
gem 'hamlit', '~> 2.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri]
  gem 'factory_girl_rails', '~> 4.7'
  gem 'capybara', '~> 2.7.0'
  gem 'selenium-webdriver'
  gem 'json_world'
  gem 'jdoc'
end

group :development do
  gem 'hamlit-rails', '~> 0.1.0'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
