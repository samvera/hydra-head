module Hydra::AccessControls
  AGENT_URL_PREFIX = "http://projecthydra.org/ns/auth/".freeze
  GROUP_AGENT_URL_PREFIX = "http://projecthydra.org/ns/auth/group".freeze
  PERSON_AGENT_URL_PREFIX = 'http://projecthydra.org/ns/auth/person'.freeze
  class Permission < AccessControlList
    type ::RDF::Vocab::ACL.Authorization
    has_many :admin_policies, inverse_of: :default_permissions, class_name: 'Hydra::AdminPolicy'

    def initialize(args)
      super()
      build_agent(args[:name], args[:type].to_s)
      build_access(args[:access])
    end

    def to_hash
      { name: agent_name, type: type, access: access }
    end

    def inspect
      agent_value = agent.first.rdf_subject.to_s.inspect if agent.first
      mode_value = mode.first.rdf_subject.to_s.inspect if mode.first
      "<#{self.class.name} id: #{id} agent: #{agent_value} mode: #{mode_value} access_to: #{access_to_id.inspect}>"
    end

    def == other
      other.is_a?(Permission) && id == other.id && self.access_to_id == other.access_to_id &&
        self.agent.first.rdf_subject == other.agent.first.rdf_subject && self.mode.first.rdf_subject == other.mode.first.rdf_subject
    end

    def attributes=(attributes)
      attrs = attributes.dup
      name = attrs.delete(:name)
      type = attrs.delete(:type)
      build_agent(name, type) if name && type
      access = attrs.delete(:access)
      build_access(access) if access
      super(attrs)
    end

    def agent_name
      parsed_agent.last
    end

    def access
      @access ||= mode.first.rdf_subject.to_s.split('#').last.downcase.sub('write', 'edit')
    end

    def type
      parsed_agent.first
    end

    # @param (optional) [Hash] opts will return the actual modes if { actual: true } is supplied
    def mode(opts={})
      return super if opts.fetch(:actual, false)
      effective_mode(super)
    end

    def effective_mode(actual_modes)
      [ModeMap.new(actual_modes).resulting_mode]
    end

    # Internal class used to determine the resulting mode, either ACL.Write, ACL.Read, or Hydra::ACL.Discover,
    # based on the actual modes found in Hydra::AccessControls::Permission::mode
    # The resulting mode versus the actual modes are defined as follows:
    #   Actual modes                             | Resulting mode
    #   ---------------------------------------- | --------------------          
    #   Hydra::ACL.Discover                      | Hydra::ACL.Discover
    #   Hydra::ACL.Discover, ACL.Read            | ACL.Read
    #   ACL.Read                                 | ACL.Read
    #   Hydra::ACL.Discover, ACL.Read, ACL.Write | ACL.Write
    #   ACL.Write                                | ACL.Write
    #   nil                                      | nil
    #   anything other than one of these above   | nil
    class ModeMap
      attr_reader :modes

      # @param [ActiveTriples::Relation] modes listing one or more of AccessControlList::Mode
      def initialize(modes)
        @modes = modes
      end

      def resulting_mode
        return map[ACL.Write.to_s] if map.keys.include?(ACL.Write)
        return map[ACL.Read.to_s] if map.keys.include?(ACL.Read)
        return map[Hydra::ACL.Discover.to_s] if map.keys.include?(Hydra::ACL.Discover)
      end

      def map
        @map ||= new_map
      end

      private
        def new_map
          result = {}
          modes.each { |mode| result[mode.id] = mode }
          result
        end
    end

    protected

      def parsed_agent
        @parsed_agent ||= agent.first.rdf_subject.to_s.sub(AGENT_URL_PREFIX, '').split('#')
      end

      def build_agent(name, type)
        raise "Can't build agent #{inspect}" unless name && type
        self.agent = case type
                     when "group"
                       Agent.new(::RDF::URI.new("#{GROUP_AGENT_URL_PREFIX}##{name}"))
                     when "person"
                       Agent.new(::RDF::URI.new("#{PERSON_AGENT_URL_PREFIX}##{name}"))
                     else
                       raise ArgumentError, "Unknown agent type #{type.inspect}"
                     end
      end

      def build_access(access)
        raise "Can't build access #{inspect}" unless access
        self.mode = case access
                    when "read"
                      [Mode.new(::ACL.Read), Mode.new(Hydra::ACL.Discover)]
                    when "edit"
                      [Mode.new(::ACL.Write), Mode.new(::ACL.Read), Mode.new(Hydra::ACL.Discover)]
                    when "discover"
                      Mode.new(Hydra::ACL.Discover)
                    else
                      raise ArgumentError, "Unknown access #{access.inspect}"
                    end
      end

  end
end
