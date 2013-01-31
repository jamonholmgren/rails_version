require "rails_version/pinger"
ActionController::Base.send :include, RailsVersion::RailsVersionMixin
ActionController::Base.send :after_filter, :ping_rails_version_server
