# RailsVersion

This gem works with http://railsversion.herokuapp.com to track all of your Rails apps
and the versions they are running. This gives you one place to see all of your rails
application versions.

## Installation

As usual, add this line to your application's Gemfile and bundle afterward:

    gem 'rails_version', ">= 0.2.2", :group => :production

Sign up and get your API key from http://railsversion.herokuapp.com, then go to your config/environments/production.rb file and add this:

    RailsVersion::Config.api_key = "API_KEY_HERE"

## Manual Ping

If you want to manually trigger a ping, go to:

    http://yourdomain.com/?rails_version_ping=API_KEY_HERE

Just replace yourdomain.com with your domain name and API_KEY_HERE with your API key.

## Configuration Options

We have good defaults, but we do expose some config options:

* `RailsVersion::Config.ping_type = :server | :image | :script` - :server is default and the safest, but you can also inject an image or javascript tag into your HTML if the :server option isn't working for you.
* `RailsVersion::Config.frequency = 100` - 100 is a 1% chance on page load of pinging our server (default). Turn this down if you have a lot of traffic or up if you have very little traffic. Your server should ping ours about once every couple days on average.
* `RailsVersion::Config.api_key = "API_KEY_HERE"` - *required* API key from http://railsversion.herokuapp.com if you're using our server.

## Code Climate

Version 0.1.0 Grade: A

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/clearsightstudio/rails_version)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
