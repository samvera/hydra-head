source "https://rubygems.org"

# BEGIN ENGINE_CART BLOCK
# engine_cart: 2.4.0
# engine_cart stanza: 2.5.0
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

    case ENV['RAILS_VERSION']
    when /^6.0/
      gem 'sass-rails', '>= 6'
      gem 'webpacker', '~> 4.0'
    when /^5.[12]/
      gem 'sass-rails', '~> 5.0'
      gem 'sprockets', '~> 3.7'
      gem 'thor', '~> 0.20'
    end
  end
end
# END ENGINE_CART BLOCK

if ENV['ACTIVE_FEDORA_VERSION']
  gem 'active-fedora', ENV['ACTIVE_FEDORA_VERSION']
else
  gem 'active-fedora', git: 'https://github.com/samvera/active_fedora.git', branch: 'updating-active-triples'
end

if ENV['BLACKLIGHT_VERSION']
  gem 'blacklight', ENV['BLACKLIGHT_VERSION']
else
  gem 'blacklight', '>= 7.26'
end

# Specify gem dependencies in hydra-head.gemspec
gemspec

