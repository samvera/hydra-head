source "https://rubygems.org"

gem 'rspec-its'

# Specify gem dependencies in hydra-head.gemspec
gemspec

# BEGIN ENGINE_CART BLOCK
# engine_cart: 1.0.1
# engine_cart stanza: 0.10.0
# the below comes from engine_cart, a gem used to test this Rails engine gem in the context of a Rails app.
file = File.expand_path('Gemfile', ENV['ENGINE_CART_DESTINATION'] || ENV['RAILS_ROOT'] || File.expand_path('.internal_test_app', File.dirname(__FILE__)))
if File.exist?(file)
  begin
    eval_gemfile file
  rescue Bundler::GemfileError => e
    Bundler.ui.warn '[EngineCart] Skipping Rails application dependencies:'
    Bundler.ui.warn e.message
  end
else
  Bundler.ui.warn "[EngineCart] Unable to find test application dependencies in #{file}, using placeholder dependencies"

  if ENV['RAILS_VERSION']
    if ENV['RAILS_VERSION'] == 'edge'
      gem 'rails', github: 'rails/rails'
      ENV['ENGINE_CART_RAILS_OPTIONS'] = '--edge --skip-turbolinks'
    else
      gem 'rails', ENV['RAILS_VERSION']
    end
  end

  case ENV['RAILS_VERSION']
  when /^5.[12]/
    gem 'sass-rails', '~> 5.0'
  when /^4.2/
    gem 'responders', '~> 2.0'
    gem 'sass-rails', '>= 5.0'
    gem 'coffee-rails', '~> 4.1.0'
  when /^4.[01]/
    gem 'sass-rails', '< 5.0'
  end
end
# END ENGINE_CART BLOCK

if !ENV['RAILS_VERSION'] || ENV['RAILS_VERSION'] =~ /^6.0/
  gem 'psych', '< 4'
end

if !ENV['RAILS_VERSION'] || ENV['RAILS_VERSION'] =~ /^5/
  gem 'rails-controller-testing'
  gem 'psych', '< 4'
end

if ENV['ACTIVE_FEDORA_VERSION']
  gem 'active-fedora', ENV['ACTIVE_FEDORA_VERSION']
end

if ENV['BLACKLIGHT_VERSION']
  gem 'blacklight', ENV['BLACKLIGHT_VERSION']
end
