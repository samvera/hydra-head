# @deprecated no longer doing permissions this way.  Will be removed no later than release 6.x
module Hydra::SuperuserAttributes

  def self.included(base)
    ActiveSupport::Deprecation.warn("Hydra::SuperuserAttributes has been deprecated and will be removed no later than release 6.  Use devise or similar.")
    super
  end

  def can_be_superuser?
    Superuser.find_by_user_id(self.id) ? true : false
  end

  def is_being_superuser?(session=nil)
    return false if session.nil?
    session[:superuser_mode] ? true : false
  end

end