require 'test/unit'
require 'lib/metar/weather'

# Unit tests for Metar::Weather abstract class
class TestWeather < Test::Unit::TestCase
	# make sure initialize throws an error as it is
	# an abstract method
	def test_initialize
		assert_raise(ArgumentError){ Metar::Weather.new }
		assert_raise(NotImplementedError){ Metar::Weather.new('BLAH') }
	end
	
	# test raw attribute accessor that also
	# normalizes raw product on setting
	def test_raw
		load 'test/weather_extend.rb'
		metar_ext = Metar::Weather.new('BLAH')
		
		metar_ext.raw = " meTAr Jfk 	\r \n ";
		assert_equal('METAR JFK', metar_ext.raw)
	end
	
	# make sure type method throws an error as it is
	# an abstract method
	def test_type
		load 'test/weather_extend.rb'
		metar_ext = Metar::Weather.new('BLAH')

		assert_not_nil(metar_ext)
		assert_raise(NotImplementedError){ metar_ext.type }
	end
end