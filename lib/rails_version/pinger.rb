module RailsVersion
  class Pinger
    attr_accessor :body

    def initialize(request, response)
      @body = response.body.to_s
      @host = request.host.to_s
      @version = Rails.version.to_s
    end

    def ping!
      inject_script_before_end_body_tag
    end

    def inject_script_before_end_body_tag
      @body.sub! /<\/[bB][oO][dD][yY]>/, "#{ping_script}</body>" if @body && @body.respond_to?(:sub!)
    end

    def ping_script
      "<script language='text/javascript' src='#{ping_url}'></script>"
    end

    def ping_url
      "#{RailsVersion::Config.server_url}/#{RailsVersion::Config.api_key}/?site=#{@host}&rails_version=#{@version}"
    end
  end
end