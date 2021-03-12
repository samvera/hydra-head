module Hydra::AccessControls
  AGENT_URL_SCHEME = 'http'.freeze
  AGENT_URL_HOST = 'projecthydra.org'.freeze
  AGENT_URL_PATH = '/ns/auth/'.freeze
  GROUP_AGENT_PATH = '/ns/auth/group'.freeze
  PERSON_AGENT_PATH = '/ns/auth/person'.freeze
  AGENT_URL_PREFIX = 'http://projecthydra.org/ns/auth/'.freeze
  GROUP_AGENT_URL_PREFIX = 'http://projecthydra.org/ns/auth/group'.freeze
  PERSON_AGENT_URL_PREFIX = 'http://projecthydra.org/ns/auth/person'.freeze
  class Permission < AccessControlList
    has_many :admin_policies, inverse_of: :default_permissions, class_name: 'Hydra::AdminPolicy'

    # @param [Hash] args
    # @option args [#to_s] :name name of agent
    # @option args [#to_s] :type type of agent: group/person
    # @option args [String] :access description of access: read/edit/discover
    def initialize(args)
      super()
      build_agent(args[:name].to_s, args[:type].to_s)
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

    def ==(other)
      other.is_a?(Permission) && id == other.id && access_to_id == other.access_to_id &&
        agent.first.rdf_subject == other.agent.first.rdf_subject && mode.first.rdf_subject == other.mode.first.rdf_subject
    end

    def assign_attributes(attributes)
      attrs = attributes.dup
      name = attrs.delete(:name)
      type = attrs.delete(:type)
      build_agent(name, type) if name && type
      access = attrs.delete(:access)
      build_access(access) if access
      super(attrs)
    end

    def agent_name
      URI.decode_www_form_component(parsed_agent.last)
    end

    def update(*)
      super.tap { reset }
    end

    def reset
      @access = nil
      @parsed_agent = nil
    end

    def access
      @access ||= mode.first.rdf_subject.to_s.split('#').last.downcase.sub('write', 'edit')
    end

    def type
      parsed_agent.first
    end

    protected

    def parsed_agent
      @parsed_agent ||= agent.first.rdf_subject.to_s.sub(AGENT_URL_PREFIX, '').split('#')
    end

    def build_agent(name, type)
      raise "Can't build agent #{inspect}" unless name && type
      self.agent = case type
                   when 'group'
                     build_agent_resource(GROUP_AGENT_PATH, name)
                   when 'person'
                     build_agent_resource(PERSON_AGENT_PATH, name)
                   else
                     raise ArgumentError, "Unknown agent type #{type.inspect}"
                   end
    end

    # The current URL.hash standard (As of March 2021) is that the post-hash portion of the URL is not percent-decoded
    # however in order to ensure backward compatibility with already recorded values we are normalizing
    # the fragment here. See https://developer.mozilla.org/en-US/docs/Web/API/URL/hash
    def build_agent_rdf(path, name)
      ::RDF::URI.new(scheme: AGENT_URL_SCHEME, host: AGENT_URL_HOST, path: path, fragment: name).normalize!
    end

    def build_agent_resource(path, name)
      [Agent.new(build_agent_rdf(path, name))]
    end

    def build_access(access)
      raise "Can't build access #{inspect}" unless access
      self.mode = case access
                  when 'read'
                    [Mode.new(::ACL.Read)]
                  when 'edit'
                    [Mode.new(::ACL.Write)]
                  when 'discover'
                    [Mode.new(Hydra::ACL.Discover)]
                  else
                    raise ArgumentError, "Unknown access #{access.inspect}"
                  end
    end
  end
end
