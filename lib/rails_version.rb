require "rails_version/version"

module RailsVersion
  class Config
    @@server_url = "https://railsversion.herokuapp.com/ping"
    ##
    # :singleton-method:
    # Specify what URL this gem will ping with its information.
    cattr_accessor :server_url

    @@frequency = 100
    ##
    # :singleton-method:
    # Tells the client how frequent (randomly out of 10000) to ping
    # the server. Default is 100 (1% of page loads).
    cattr_accessor :frequency

    @@account_identifier = ""
    ##
    # :singleton-method:
    # Tells the client how frequent (randomly out of 100) to ping
    # the server.
    cattr_accessor :frequency
  end
end
