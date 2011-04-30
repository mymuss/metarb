require 'test/unit'
require 'lib/metar/speci'

# Unit tests for Metar::Speci class
class TestSpeci < Test::Unit::TestCase
	# Test overriden type() method
	def test_type
		speci = Metar::Speci.new("   sPEcI kSFo  \r \n ")
		assert_not_nil(speci)
		assert_equal(:SPECI, speci.type)
		assert_equal('SPECI KSFO', speci.raw)
	end
end
