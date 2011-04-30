# Abstract parent class for all supported weather products
module Metar
	class Weather
		# raw weather product (report or forecast)
		attr_reader :raw

		# station identifier (normally airport name)
		attr_accessor :station

		# report time
		attr_accessor :time

		# Parametrized initializer
		# This is an abstract method and subclasses must
		# implement it
		def initialize(raw)
			raise NotImplementedError, 'initialize() not implemented'
		end

		# raw attribute setter that formats raw product
		def raw=(raw)
			@raw = raw.strip.chomp("\r\n\t").upcase
		end

		# Return type of current weather product
		# This is an abstract method and subclasses must
		# implement it
		def type
			raise NotImplementedError, 'Abstract type() method not implemented'
		end
	end
end