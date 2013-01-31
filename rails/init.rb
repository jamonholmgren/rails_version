require "rails_version/pinger"
ActionController::Base.send :include, RailsVersion::RailsVersionMixin
ActionController::Base.send :after_filter, :add_google_analytics_code
