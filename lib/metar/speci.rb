require 'lib/metar/metar'

# This class represents special (`SPECI') report
# Otherwise it's no different from routine (`METAR')
module Metar
	class Speci < Metar
		# initializer implementation
		def initialize(raw)
			self.raw = raw
		end

		# abstract method implementation
		def type
			:SPECI
		end
	end
end