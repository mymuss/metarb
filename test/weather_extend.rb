require 'lib/metar/weather'

# This is just an extension to the Weather class
# that does not raise an error in initializer
# It should NOT be used except in unit tests
module Metar
	class Weather
		def initialize(raw)
		end
	end
end