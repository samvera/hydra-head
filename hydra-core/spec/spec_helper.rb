# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'engine_cart'
path = File.expand_path(File.join('..', '..', '..', '.internal_test_app'), __FILE__)
EngineCart.load_application! path

require 'bundler/setup'
require 'rspec/rails'
require 'hydra-core'

require 'simplecov'
require 'coveralls'
require 'rails-controller-testing'

SimpleCov.root(File.expand_path('../..', __dir__))
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)
SimpleCov.start('rails') do
  add_filter %r{lib/generators/.*\.rb}
end

ActiveFedora::Base.logger = Logger.new(STDOUT)

require 'active_fedora/cleaner'
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include ::Rails::Controller::Testing::TemplateAssertions, type: :controller
  config.include ::Rails::Controller::Testing::TestProcess, type: :controller
  config.include ::Rails::Controller::Testing::Integration, type: :controller
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    ActiveFedora::Cleaner.clean!
  end
end
