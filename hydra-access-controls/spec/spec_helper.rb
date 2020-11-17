ENV['RAILS_ENV'] ||= 'test'
require 'engine_cart'
path = File.expand_path(File.join('..', '..', '..', '.internal_test_app'), __FILE__)
EngineCart.load_application! path

require 'hydra-access-controls'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
Hydra::Engine.config.autoload_paths.each { |path| $LOAD_PATH.unshift path }

require 'byebug' unless ENV['CI']

def coverage_needed?
  ENV['COVERAGE'] || ENV['CI']
end

if RUBY_VERSION =~ /^1.9/ && coverage_needed?
  require 'simplecov'
  require 'coveralls'

  SimpleCov.root(File.expand_path('../../../', __FILE__))
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  )
  SimpleCov.start('rails')
end

# Since we're not doing a Rails Engine test, we have to load these classes manually:
require 'active_support'
require 'active_support/dependencies'
relative_load_paths = ["#{Blacklight.root}/app/controllers/concerns",
                       "#{Blacklight.root}/app/models",
                       "app/models",
                       "app/models/concerns",
                       "app/indexers",
                       "app/services",
                       "app/validators",
                       "app/vocabularies"]
ActiveSupport::Dependencies.autoload_paths += relative_load_paths

require 'support/mods_asset'
require 'support/solr_document'
require "support/user"
require "factory_bot"
require 'rspec/mocks'
require 'rspec/its'
require 'factories/user'
require 'factories/objects'

# HttpLogger.logger = Logger.new(STDOUT)
# HttpLogger.ignore = [/localhost:8983\/solr/]
# HttpLogger.colorize = false

ActiveFedora::Base.logger = Logger.new(STDOUT)

require 'active_fedora/cleaner'
RSpec.configure do |config|
  config.before(:each) do
    ActiveFedora::Cleaner.clean!
  end
end
