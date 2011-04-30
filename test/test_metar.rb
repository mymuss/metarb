require 'test/unit'
require 'lib/metar/metar'

# Unit tests for Metar::Metar class
class TestMetar < Test::Unit::TestCase
	# Test overriden type() method
	def test_type
		metar = Metar::Metar.new("   metAR KBos  \r \n ")
		assert_not_nil(metar)
		assert_equal(:METAR, metar.type)
		assert_equal('METAR KBOS', metar.raw)
	end
end
