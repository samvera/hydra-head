# When the log level is set to debug, log all LDP HTTP API traffic
module HydraHead
  class LogSubscriber < ActiveSupport::LogSubscriber
    def initialize
      super
      @odd = false
    end

    def http(event)
      return unless logger.debug?

      payload = event.payload

      name  = "#{payload[:name]} (#{event.duration.round(1)}ms)"
      url   = payload[:url] || "[no url]"

      if odd?
        name = color(name, CYAN, true)
        url  = color(url, nil, true)
      else
        name = color(name, MAGENTA, true)
      end

      debug "  #{name} #{url} Service: #{payload[:ldp_client]}"
    end

    def odd?
      @odd = !@odd
    end

    def logger
      ActiveFedora::Base.logger
    end
  end
end

HydraHead::LogSubscriber.attach_to :ldp
