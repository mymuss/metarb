require 'lib/metar/weather'

# This class represents TAF forecast
module Metar
	class Taf < Weather
		# initializer implementation
		def initialize(raw)
			self.raw = raw
		end

		# abstract method implementation
		def type
			:TAF
		end
	end
end