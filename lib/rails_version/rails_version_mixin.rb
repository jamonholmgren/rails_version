module RailsVersion
  module RailsVersionMixin
    def ping_rails_version_server
      # Rolls the dice. If random number is < than your frequency, trigger the script
      raise StandardError.new("RailsVersion requires RailsVersion::Config.api_key to be set in this environment.") unless RailsVersion::Config.api_key
      if rand(10000) < RailsVersion::Config.frequency
        pinger = RailsVersion::Pinger.new(request, response)
        response.body = pinger.body if pinger.ping!
      end
    end
  end
end