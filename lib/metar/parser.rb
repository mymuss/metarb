require 'lib/metar/metar'
require 'lib/metar/speci'
require 'lib/metar/taf'

module Metar
	class Parser
		def self.parse(raw)
			wx = init_type(raw)
			if :TAF == wx.type
				raise NotImplementedException 'TAF not supported'
			end

			my_raw = wx.raw
			if my_raw.end_with?('=')
				my_raw.chop!
			else
				raise RuntimeError, "Terminator not found raw=#{my_raw[0,500]}"
			end
			
			raw_arr = my_raw.gsub!(/[\r\t\n]/, ' ').split
			raw_arr.shift # product type
			
			wx.station = parse_station(raw_arr.shift)
			wx.time    = parse_time(raw_err.shift)
			
			# next tokens are optional and may be ambiguous
			while token = raw_arr.shift
				
			end
		end

	private
		# Check weather product type in _raw_ product
		# and initialize a new object of that type
		# Returns the new object
		def self.init_type(raw)
			type = raw[0, 6]
			
			if type.start_with?('METAR ')
				wx = Metar.new(raw)
			elsif type.start_with?('SPECI ')
				wx = Speci.new(raw)
			elsif type.start_with?('TAF ')
				wx = Taf.new(raw)
			else
				raise RuntimeError, "Unknown report type, raw=#{raw[0,100]}"
			end
			
			return wx
		end
	
		# Parse _station_ name, basically
		# just validate and return it
		# Return station name if valid
		# Raise error if invalid
		def self.parse_station(station)
			unless station =~ /^[\w\d]{3,4}$/
				raise RuntimeError, "Invalid station=#{station}"
			end
			
			return station
		end
	
		# Parse product generation _time_, expects time in form DDHHMMZ
		# Assumes the report is fresh, i.e. issued less than 15 days ago
		# Return Time object
		# Raise error if time is invalid
		def self.parse_time(time)
			unless time =~ /^(\d{2})(\d{2})(\d{2})Z$/
				raise RuntimeError, "Invalid time=#{time}"
			end
			
			day		= $1.to_i
			hour	= $2.to_i
			min		= $3.to_i
			
			unless (1 <= day) && (31 >= day)
				raise RuntimeError, "Invalid date: day=#{day}, time=#{time}"
			end
			unless (0 <= hour) && (23 >= hour)
				raise RuntimeError, "Invalid date: hour=#{hour}, time=#{time}"
			end
			unless (0 <= min) && (59 >= min)
				raise RuntimeError, "Invalid date: min=#{min}, time=#{time}"
			end
			
			now = Time.now.getgm
			
			# we only have day, so if current day of month is
			# less than 15th then check if there's a chance
			# it from last month's report
			month = now.month
			month -= 1 if ((now.day < 15) && (day.to_i >= 15))
			
			return Time.gm(now.year, month, day, hour, min)
		end
	end
end