# Helper that converts between different unit types
# By default changes precision to most frequently
# used in aviation weather reports and forecasts
#
# This is NOT a general purpose unit converter! It
# rounds off results to precision commonly used in
# aviation and may assume
module Metar
	class Units
		# each element is an array of
		# [group name, default precision,
		# and optional hash of coefficients
		# for each other unit of the same group]
	 	@@groups = {
	 		# temperature (special case, no coefficients)
			:c		=> ['temperature', 0, nil],
			:f		=> ['temperature', 0, nil],
			
			# speed
			:kts	=> ['speed', 0, {
										:mph	=> 1.15077945,
										:kph	=> 1.852,
										:mps	=> 0.514444444,
									}],
			:mph	=> ['speed', 0, {
										:kts	=> 0.868976242,
										:kph	=> 1.609344,
										:mps	=> 0.44704,
									}],
			:kph	=> ['speed', 0, {
										:kts	=> 0.539956803,
										:mph	=> 0.621371192,
										:mps	=> 0.277777778,
									}],
			:mps	=> ['speed', 0, {
										:kts	=> 1.94384449,
										:mph	=> 2.23693629,
										:kph	=> 3.6,
									}],
			
			# pressure
			:inhg	=> ['pressure', 2, {
										:hpa	=> 33.86389,
										:mb		=> 33.86389,
										:mmhg	=> 25.399999705,
										}],
			:hpa	=> ['pressure', 0, {
										:inhg	=> 0.0295299831,
										:mb		=> 1.0,
										:mmhg	=> 0.7500637554,
										}],
			:mb		=> ['pressure', 0, {
										:inhg	=> 0.0295299831,
										:hpa	=> 1.0,
										:mmhg	=> 0.7500637554,
										}],
			:mmhg	=> ['pressure', 0, {
										:inhg	=> 0.0393700792,
										:hpa	=> 1.33322,
										:mb		=> 1.33322,
										}],
			
			# distance
			:ft		=> ['distance', 0, {
										:m		=> 0.3048,
										:km		=> 0.0003048,
										:sm		=> 0.000189393939,
										:nm		=> 0.000164578834,
										}],
			:m		=> ['distance', 0, {
										:ft		=> 3.2808399,
										:km		=> 0.001,
										:sm		=> 0.000621371192,
										:nm		=> 0.000539956803,
										}],
			:km		=> ['distance', 0, {
										:ft		=> 3280.8399,
										:m		=> 1000.0,
										:sm		=> 0.621371192,
										:nm		=> 0.539956803,
										}],
			:sm		=> ['distance', 0, {
										:ft		=> 5280.0,
										:m		=> 1609.344,
										:km		=> 1.609344,
										:nm		=> 0.868976242,
										}],
			:nm		=> ['distance', 0, {
										:ft		=> 6076.11549,
										:m		=> 1852.0,
										:km		=> 1.852,
										:sm		=> 1.15077945,
										}],			
		}
		
		# Convert the _value_ from _from_ units to _to_ units
		def self.convert(from, to, value)
			if !@@groups.has_key?(from) || !@@groups.has_key?(to)
				raise ArgumentError, "Units not supported: #{from} to #{to}"
			end
			
			if @@groups[from][0] != @@groups[to][0]
				raise ArgumentError, "Cannot convert from #{from} to #{to}"
			end
	
			return nil if value.nil?
	
			if from == to
				# just fix the precision
				return value.round(@@groups[to][1])
			end
			
			
			# temperature is a special case, it's not a coefficient
			# conversion
			if 'temperature' == @@groups[from][0]
				return convert_temperature(from, to, value, @@groups[to][1])
			end
			
			return convert_coef(value, @@groups[from][2][to], @@groups[to][1])
		end
		
		# Convert temperature _value_ from _from_ units to
		# _to_ units with specified _precision_
		def self.convert_temperature(from, to, value, precision)
			if (:c == from) && (:f == to)
				return (value * 9.0 / 5.0 + 32.0).round(precision)
			elsif (:f == from) && (:c == to)
				return ((value - 32.0) * 5.0 / 9.0).round(precision)
			end
			
			raise ArgumentError, "Unknown temperature units: from #{from} to #{to}"
		end

	private		
		# Convert by applying coefficient _coef_ to _value
		# and return with specified _precision_
		def self.convert_coef(value, coef, precision)
			return (value * coef).round(precision)
		end
	
	public	
		# default catchall method for calls in form
		# unit1_to_unit2(value)
		def self.method_missing(name, *args, &block)
			if name =~ /^(\w{1,4})_to_(\w{1,4})$/
				return convert(:"#{$1}", :"#{$2}", *args)
			end
		
			super
		end
	end
end