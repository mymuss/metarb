require 'test/unit'
require 'lib/metar/parser'

# Unit tests for Metar::Parser class
class TestParser < Test::Unit::TestCase
	def test_parse
	end
	
	def test_init_type
		metar = Metar::Parser.send(:init_type, 'METAR KJFK=')
		assert_not_nil(metar)
		assert_equal(:METAR, metar.type)

		speci = Metar::Parser.send(:init_type, 'SPECI KBOS=')
		assert_not_nil(speci)
		assert_equal(:SPECI, speci.type)

		taf = Metar::Parser.send(:init_type, 'TAF KEWR=')
		assert_not_nil(taf)
		assert_equal(:TAF, taf.type)

		assert_raise(RuntimeError){ Metar::Parser.send(:init_type, 'BLAHH KORD=') }
	end
	
	def test_parse_station
		assert_equal('KJFK', Metar::Parser.send(:parse_station, 'KJFK'))
		assert_equal('JFK', Metar::Parser.send(:parse_station, 'JFK'))
		assert_equal('UKBB', Metar::Parser.send(:parse_station, 'UKBB'))
		assert_equal('47N', Metar::Parser.send(:parse_station, '47N'))

		assert_raise(RuntimeError){ Metar::Parser.send(:parse_station, 'X') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_station, '5') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_station, 'Logan') }
	end
	
	def test_parse_time
		now = Time.now.getgm

		t = Metar::Parser.send(:parse_time, '061023Z')
		assert_equal(6,  t.day)
		assert_equal(10, t.hour)
		assert_equal(23, t.min)
		assert((t.month - now.month).abs <= 1)

		t = Metar::Parser.send(:parse_time, '170211Z')
		assert_equal(17,  t.day)
		assert_equal(2,  t.hour)
		assert_equal(11, t.min)
		assert((t.month - now.month).abs <= 1)
		
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, 170211) }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '170211') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '000Z') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, 'Z') }

		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '000211Z') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '320211Z') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '172511Z') }
		assert_raise(RuntimeError){ Metar::Parser.send(:parse_time, '170260Z') }
	end
end
