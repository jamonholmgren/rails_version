require 'test/unit'
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
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert body.include?("</script></body>")
    assert body.include?("/TESTSCRIPT/")
  end
  def test_pinger_injects_image
    RailsVersion::Config.ping_type = :image
    RailsVersion::Config.api_key = "TESTIMAGE"
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert body.include?("<img src='")
    assert body.include?("/TESTIMAGE/")
  end
  def test_pinger_server
    RailsVersion::Config.ping_type = :server
    RailsVersion::Config.server_url = "http://railsversion.herokuapp.com/ping"
    RailsVersion::Config.api_key = "TESTSERVER"
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    # Pretty weak, I know, but at least we know the library was loaded
    # and there aren't major syntax errors.
    assert Object.const_defined?('Net')
  end
end
