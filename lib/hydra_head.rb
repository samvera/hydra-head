require File.expand_path('hydra_head/version', File.dirname(__FILE__))

module HydraHead
  require 'hydra-core'

  def self.root
    @root ||= File.expand_path(File.dirname(__FILE__))
  end

end
