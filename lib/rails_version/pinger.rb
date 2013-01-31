module RailsVersion
  class Pinger
    def initialize(body)
      @body = body
    end

    def ping
      inject_script_before_end_body_tag
    end

    def inject_script_before_end_body_tag
      @body.sub! /<\/[bB][oO][dD][yY]>/, "#{ping_script}</body>" if @body && @body.respond_to?(:sub!)
    end

    def ping_script
      "<script language='text/javascript' src='#{RailsVersion::Config.server_url}'></script>"
    end
  end
end