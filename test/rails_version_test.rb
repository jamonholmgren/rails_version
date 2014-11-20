require 'test/unit'
require 'webmock/minitest'
require 'rails_version'
require 'rails_version/pinger'

class FakeRequest
  def host
    "www.example.com"
  end
end

class FakeResponse
  def body
    "<html><body><h1>TEST</h1><p>TEST2</p></body></html>"
  end
end

class RailsVersionTest < Test::Unit::TestCase

  def test_pinger_injects_script
    RailsVersion::Config.ping_type = :script
    RailsVersion::Config.api_key = "TESTSCRIPT"
    RailsVersion::Config.app_name = "TESTAPP"
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert body.include?("</script></body>")
    assert body.include?("/TESTSCRIPT/")
    assert body.include?("&app_name=TESTAPP")
  end

  def test_pinger_injects_image
    RailsVersion::Config.ping_type = :image
    RailsVersion::Config.api_key = "TESTIMAGE"
    RailsVersion::Config.app_name = "TESTAPP"
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert body.include?("<img src='")
    assert body.include?("/TESTIMAGE/")
    assert body.include?("&app_name=TESTAPP")
  end

  def test_pinger_server
    RailsVersion::Config.ping_type = :server
    RailsVersion::Config.api_key = "TESTSERVER"
    RailsVersion::Config.app_name = "TESTAPP"
    stub_get = stub_request(:get, "https://railsversion.herokuapp.com/ping/TESTSERVER/").with(
      query: {
        "app_name" => "TESTAPP",
        "rails_version" => "Non-Rails",
        "site" => "www.example.com"
      }
    )

    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    url = pinger.ping_url
    pinger.ping!

    assert url.include?("/TESTSERVER/")
    assert url.include?("&app_name=TESTAPP")
    assert_requested(stub_get)
  end
end
