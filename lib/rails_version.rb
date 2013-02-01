require "rails_version/version"
require "rails_version/pinger"
require "rails_version/rails_version_mixin"
require 'rails_version/railtie' if defined? Rails

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
    # Specify what type of ping to use.
    # Options:
    # :server (default: safest, server-side)
    # :image  (embed img tag before </body>)
    # :script (embeds external js tag)
    def self.ping_type
      @@ping_type ||= :server
    end
    def self.ping_type=(v)
      @@ping_type = v
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
    # API Key obtained from railsversion.herokuapp.com
    def self.api_key
      @@api_key ||= nil
    end
    def self.api_key=(v)
      @@api_key = v
    end
  end
end
