module RailsVersion
  class Railtie < Rails::Railtie
    initializer "rails_version" do |app|
      ActionController::Base.send :include, RailsVersion::RailsVersionMixin
      ActionController::Base.send :after_filter, :ping_rails_version_server
    end
  end
end