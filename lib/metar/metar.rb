require 'lib/metar/weather'

# This class represents standard (and some non-standard, such as
# North America speecific) fields from METAR
module Metar
	class Metar < Weather
		# standard METAR/SPECI fields
		attr_accessor \
			:wind,			# hash with keys: :dir, :speed, :gust, :from, :to
			:visibility,	# prevailing visibility
			:rvr,			# array of hashes {:rwy, :visibility, :trend}
			:wx_phenomena,	# see list of possible values below
			:sky_condition,	# array of hashes for each layer {:type, :agl}
			:temp,			# temperature, C
			:dew_point,		# dewpoint, C
			:altimeter,		# altimeter setting
			:trend,			# trend forecast (non-FAA)
			:rwy_condition,	# runway condition
			:summary		# e.g. CAVOK (non-FAA)
	
		# North America Remarks (RMK) fields
		attr_accessor \
			:sensor_type,	# A02 for automated percipitation sensor, else A01
			:begin,			# begin section, hash {:wx_phenomena, :time}
			:slp,			# Sea Level Pressure in hPa
			:percipitation,	# peercipitation accumulation, in
			:rmk_temp,		# more precise temperature
			:rmk_dewpoint	# more precise dewpoint

		# initializer implementation
		def initialize(raw)
			self.raw = raw
		end

		# abstract method implementation
		def type
			:METAR
		end
	end
end