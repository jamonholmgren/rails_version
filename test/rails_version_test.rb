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
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert_equal true, body.include?("</script></body>")
  end
  def test_pinger_injects_image
    RailsVersion::Config.ping_type = :image
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    body = pinger.body
    assert_equal true, body.include?("<img src='")
  end
  def test_pinger_server
    RailsVersion::Config.ping_type = :server
    pinger = RailsVersion::Pinger.new(FakeRequest.new, FakeResponse.new)
    pinger.ping!
    # Pretty weak, I know, but at least the library was loaded
    assert_equal true, Object.const_defined?('Net')
  end
end
