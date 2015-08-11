require_relative 'hydra_head/version'
module HydraHead
  require 'hydra-core'

  def self.version
    VERSION
  end

  def self.root
    @root ||= File.expand_path(File.dirname(__FILE__))
  end

end
