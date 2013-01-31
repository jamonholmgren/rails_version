module RailsVersion
  module RailsVersionMixin
    def ping_rails_version_server
      # Rolls the dice. If random number is < than your frequency, trigger the script
      if rand(100) < RailsVersion::Config.frequency
        ping = RailsVersion::Pinger.new
        ping.add_script
      end
    end
  end
end