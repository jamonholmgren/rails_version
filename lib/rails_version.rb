require "rails_version/version"

module RailsVersion
  class Config
    ##
    # :singleton-method:
    # Specify what URL this gem will ping with its information.
    def self.server_url
      @@server_url ||= "https://railsversion.herokuapp.com/ping"
    end
    def self.server_url=(v)
      @@server_url = v
    end

    ##
    # :singleton-method:
    # Tells the client how frequent (randomly out of 10000) to ping
    # the server. Default is 100 (1% of page loads).
    def self.frequency
      @@frequency ||= 100
    end
    def self.frequency=(v)
      @@frequency = v
    end

    ##
    # :singleton-method:
    # Tells the client how frequent (randomly out of 100) to ping
    # the server.
    def self.account_identifier
      @@account_identifier ||= nil
    end
    def self.account_identifier=(v)
      @@account_identifier = v
    end
  end
end
