require 'rails'
require 'active-fedora'
require 'blacklight'
require 'cancan'
require "deprecation"
require 'blacklight-access_controls'

module Hydra
  extend ActiveSupport::Autoload
  autoload :User
  autoload :AccessControlsEnforcement
  autoload :PolicyAwareAccessControlsEnforcement
  autoload :Ability
  autoload :Config
  autoload :PolicyAwareAbility
  autoload :AdminPolicy
  autoload :AdminPolicyBehavior
  autoload :RoleMapperBehavior
  autoload :PermissionsQuery
  autoload :IpBasedGroups

  class << self
    def configure(_ = nil)
      @config ||= Config.new
      yield @config if block_given?
      @config
    end
    alias :config :configure
  end

  class Engine < Rails::Engine
    config.before_configuration do
      ActiveSupport::Inflector.inflections(:en) do |inflect|
        inflect.acronym 'ACL'
      end
    end
  end

  # This error is raised when a user isn't allowed to access a given controller action.
  # This usually happens within a call to AccessControlsEnforcement#enforce_access_controls but can be
  # raised manually.
  class AccessDenied < ::CanCan::AccessDenied; end
end

require 'active_fedora/accessible_by'

# While we support ActiveFedora 10 and 11, alias ActiveFedora::Indexing and
# ActiveFedora::Indexing::Inserter to Solrizer
require 'active_fedora/version'
if ActiveFedora.version.split('.').first.to_i < 12
  ActiveFedora::Indexing::Inserter   = Solrizer
  ActiveFedora::Indexing::Descriptor = Solrizer::Descriptor
end
