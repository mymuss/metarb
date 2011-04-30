require 'test/unit'
require 'lib/metar/taf'

# Unit tests for Metar::Taf class
class TestTaf < Test::Unit::TestCase
	# Test overriden type() method
	def test_type
		taf = Metar::Taf.new("   tAF KEwr  \r \n ")
		assert_not_nil(taf)
		assert_equal(:TAF, taf.type)
		assert_equal('TAF KEWR', taf.raw)
	end
end
