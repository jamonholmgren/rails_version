require 'test/unit'
require 'rails_version'
require 'rails_version/pinger'

class RailsVersionTest < Test::Unit::TestCase
  def test_pinger_injects_script
    body = "<html><body><h1>TEST</h1><p>TEST2</p></body></html>"
    pinger = RailsVersion::Pinger.new(body)
    pinger.inject_script_before_end_body_tag
    assert_equal true, body.include?("</script></body>")
  end
end
