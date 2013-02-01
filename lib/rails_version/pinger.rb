module RailsVersion
  class Pinger
    attr_accessor :body, :version, :host

    def initialize(request, response)
      @body = response.body.to_s
      @host = request.host.to_s
      @version = "Non-Rails"
      @version = Rails.version.to_s if Object.const_defined?('Rails')
    end

    def ping!
      case RailsVersion::Config.ping_type.to_sym
      when :script
        inject_script_before_end_body_tag(ping_script)
      when :server
        require 'net/http'
        url = URI.parse(ping_url)
        req = Net::HTTP::Get.new(url.path)
        res = Net::HTTP.start(url.host, url.port) { |http|
          http.request(req)
        }
        url = req = res = nil # Dump any response.
        return false
      else
        inject_script_before_end_body_tag(ping_image)
      end
    rescue Timeout::Error
      false
    end

    def inject_script_before_end_body_tag(ping_html)
      @body.sub! /<\/[bB][oO][dD][yY]>/, "#{ping_html}</body>" if @body && @body.respond_to?(:sub!)
    end

    def ping_script
      "<script language='text/javascript' src='#{ping_url}'></script>"
    end

    def ping_image
      "<img src='#{ping_url}' style='display:none;visibility:hidden' width='0' height='0' />"
    end

    def ping_url
      "#{RailsVersion::Config.server_url}/#{RailsVersion::Config.api_key}/?site=#{@host}&rails_version=#{@version}"
    end
  end
end