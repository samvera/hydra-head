source 'http://rubygems.org'

gem "sqlite3"

group :development, :test do
    gem "rspec"
    gem "rspec-rails", ">=2.3.0"
    gem "cucumber-rails"
    gem "database_cleaner"
    gem "capybara", ">= 0.4.0"
    gem "webrat"
    
    gem "bundler", "~> 1.0.0"
    gem "jeweler", "~> 1.5.2"
    gem "rcov", ">= 0"
    
    if RUBY_VERSION < '1.9'
      gem 'ruby-debug', ">= 0.10.3"
    else
      gem 'ruby-debug19'
    end

end
 
# Please see hydra-head.gemspec for runtime dependency information.

gemspec

