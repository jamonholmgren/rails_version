module RailsVersion
  module RailsVersionMixin
    def ping_rails_version_server
      # Rolls the dice. If random number is < than your frequency, trigger the script
      if rand(10000) < RailsVersion::Config.frequency
        pinger = RailsVersion::Pinger.new(response.body)
        pinger.ping!
      end
    end
  end
end