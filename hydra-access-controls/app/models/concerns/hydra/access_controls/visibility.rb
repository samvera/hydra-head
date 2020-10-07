module Hydra::AccessControls
  module Visibility
    extend ActiveSupport::Concern

    included do
      # ActiveModel::Dirty requires defining the attribute method
      # @see https://api.rubyonrails.org/classes/ActiveModel/Dirty.html
      define_attribute_methods :visibility
      # instance variable needs to be initialized here based upon what is in read_groups
      after_initialize { @visibility = visibility }
    end

    def visibility=(value)
      return if value.nil?
      # only set explicit permissions
      case value
      when AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
        public_visibility!
      when AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
        registered_visibility!
      when AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
        private_visibility!
      else
        raise ArgumentError, "Invalid visibility: #{value.inspect}"
      end
      @visibility = value
    end

    def visibility
      if read_groups.include? AccessRight::PERMISSION_TEXT_VALUE_PUBLIC
        AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      elsif read_groups.include? AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED
        AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
      else
        AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
      end
    end

    # Overridden for ActiveModel::Dirty tracking of visibility
    # Required by ActiveModel::AttributeMethods
    # @see https://api.rubyonrails.org/classes/ActiveModel/AttributeMethods.html
    # An instance variable is used to avoid infinite recursion caused by calling #visibility
    # Using this approach requires setting visibility read groups through #visibility=
    # instead of manipulating them directly if #visibility_changed? is expected to work correctly.
    def attributes
      super.merge({ 'visibility' => @visibility })
    end

    private

      # Override represented_visibility if you want to add another visibility that is
      # represented as a read group (e.g. on-campus)
      # @return [Array] a list of visibility types that are represented as read groups
      def represented_visibility
        [AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED,
         AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
      end

      def public_visibility!
        visibility_will_change! unless visibility == AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
        remove_groups = represented_visibility - [AccessRight::PERMISSION_TEXT_VALUE_PUBLIC]
        set_read_groups([AccessRight::PERMISSION_TEXT_VALUE_PUBLIC], remove_groups)
      end

      def registered_visibility!
        visibility_will_change! unless visibility == AccessRight::VISIBILITY_TEXT_VALUE_AUTHENTICATED
        remove_groups = represented_visibility - [AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED]
        set_read_groups([AccessRight::PERMISSION_TEXT_VALUE_AUTHENTICATED], remove_groups)
      end

      def private_visibility!
        visibility_will_change! unless visibility == AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
        set_read_groups([], represented_visibility)
      end
  end
end
