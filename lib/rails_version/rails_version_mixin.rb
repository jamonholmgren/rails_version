module RailsVersion
  module RailsVersionMixin
    def ping_rails_version_server
      # Rolls the dice. If random number is < than your frequency, trigger the script
      raise StandardError.new("RailsVersion requires RailsVersion::Config.api_key to be set in this environment.") unless RailsVersion::Config.api_key
      manual_ping = params[:rails_version_ping] == RailsVersion::Config.api_key
      if manual_ping || rand(10000) < RailsVersion::Config.frequency
        pinger = RailsVersion::Pinger.new(request, response)
        response.body = pinger.body if pinger.ping!
      end
    rescue OpenURI::HTTPError
      nil # No HTTPError here! Nuh uh. Nope. Nothing to see here.
    end
  end
end