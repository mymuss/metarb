require 'test/unit'
require 'lib/metar/units'

# Unit tests for Metar::Units static methods
class TestUnits < Test::Unit::TestCase
	### Common API
	def test_convert
		assert_raise(ArgumentError){ Metar::Units.convert(:c, :hpa, 1) }
		assert_raise(ArgumentError){ Metar::Units.convert(:m, :hpa, 1) }
		assert_raise(ArgumentError){ Metar::Units.convert(:foo, :bar, 1) }
		assert_raise(ArgumentError){ Metar::Units.convert(:foo, :foo, 1) }
	end
	
	def test_convert_coef
		assert_equal(3.0, Metar::Units.send(:convert_coef, 100, 0.025, 0))
		assert_equal(2.5, Metar::Units.send(:convert_coef, 100, 0.025, 4))
		assert_equal(0.0003, Metar::Units.send(:convert_coef, 100, 0.0000025, 4))
	end
	
	def test_missing_method
		assert_raise(NoMethodError){ Metar::Units.foobar }
		assert_raise(NoMethodError){ Metar::Units.foobar_to_baz }
		assert_raise(NoMethodError){ Metar::Units.baz_to_foobar }
		assert_raise(NoMethodError){ Metar::Units.foobar_to_ }
		assert_raise(NoMethodError){ Metar::Units._to_foobar }
	end
	
	### Temperature
	FRIGORIFIC_TEMP_C	= -17.78
	FRIGORIFIC_TEMP_F	= 0.0
	FREEZING_TEMP_C		= 0.0
	FREEZING_TEMP_F		= 32.0
	BOILING_TEMP_C		= 100.0
	BOILING_TEMP_F		= 212.0

	def test_c_to_f
		assert_nil(Metar::Units.c_to_f(nil))
		assert_equal(FRIGORIFIC_TEMP_F.round(0), Metar::Units.c_to_f(FRIGORIFIC_TEMP_C))
		assert_equal(FREEZING_TEMP_F.round(0), Metar::Units.c_to_f(FREEZING_TEMP_C))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.c_to_f(BOILING_TEMP_C))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.c_to_f(BOILING_TEMP_C + 0.00001))
		
		assert_nil(Metar::Units.convert(:c, :f, nil))
		assert_equal(FRIGORIFIC_TEMP_F.round(0), Metar::Units.convert(:c, :f, FRIGORIFIC_TEMP_C))
		assert_equal(FREEZING_TEMP_F.round(0), Metar::Units.convert(:c, :f, FREEZING_TEMP_C))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.convert(:c, :f, BOILING_TEMP_C))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.convert(:c, :f, BOILING_TEMP_C + 0.00001))

		assert_equal(FRIGORIFIC_TEMP_F.round(0), Metar::Units.convert_temperature(:c, :f, FRIGORIFIC_TEMP_C, 0))
		assert_equal(FREEZING_TEMP_F.round(0), Metar::Units.convert_temperature(:c, :f, FREEZING_TEMP_C, 0))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.convert_temperature(:c, :f, BOILING_TEMP_C, 0))
		assert_equal(BOILING_TEMP_F.round(0), Metar::Units.convert_temperature(:c, :f, BOILING_TEMP_C + 0.00001, 0))
	end
	def test_f_to_c
		assert_nil(Metar::Units.f_to_c(nil))
		assert_equal(FRIGORIFIC_TEMP_C.round(0), Metar::Units.f_to_c(FRIGORIFIC_TEMP_F))
		assert_equal(FREEZING_TEMP_C.round(0), Metar::Units.f_to_c(FREEZING_TEMP_F))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.f_to_c(BOILING_TEMP_F))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.f_to_c(BOILING_TEMP_F + 0.00001))
		
		assert_nil(Metar::Units.convert(:f, :c, nil))
		assert_equal(FRIGORIFIC_TEMP_C.round(0), Metar::Units.convert(:f, :c, FRIGORIFIC_TEMP_F))
		assert_equal(FREEZING_TEMP_C.round(0), Metar::Units.convert(:f, :c, FREEZING_TEMP_F))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.convert(:f, :c, BOILING_TEMP_F))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.convert(:f, :c, BOILING_TEMP_F + 0.00001))

		assert_equal(FRIGORIFIC_TEMP_C.round(0), Metar::Units.convert_temperature(:f, :c, FRIGORIFIC_TEMP_F, 0))
		assert_equal(FREEZING_TEMP_C.round(0), Metar::Units.convert_temperature(:f, :c, FREEZING_TEMP_F, 0))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.convert_temperature(:f, :c, BOILING_TEMP_F, 0))
		assert_equal(BOILING_TEMP_C.round(0), Metar::Units.convert_temperature(:f, :c, BOILING_TEMP_F + 0.00001, 0))
	end
	
	
	### Speed
	SPEED_LIMIT_BRAVO_KTS = 250.0
	SPEED_LIMIT_BRAVO_MPH = 288.0
	SPEED_LIMIT_BRAVO_KPH = 463.0
	SPEED_LIMIT_BRAVO_MPS = 128.61111
	
	def test_kts_to_mph
		assert_nil(Metar::Units.kts_to_mph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.kts_to_mph(SPEED_LIMIT_BRAVO_KTS))

		assert_nil(Metar::Units.convert(:kts, :mph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.convert(:kts, :mph, SPEED_LIMIT_BRAVO_KTS))
	end
	def test_mph_to_kts
		assert_nil(Metar::Units.mph_to_kts(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.mph_to_kts(SPEED_LIMIT_BRAVO_MPH))

		assert_nil(Metar::Units.convert(:mph, :kts, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.convert(:mph, :kts, SPEED_LIMIT_BRAVO_MPH))
	end

	def test_kts_to_kph
		assert_nil(Metar::Units.kts_to_kph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.kts_to_kph(SPEED_LIMIT_BRAVO_KTS))

		assert_nil(Metar::Units.convert(:kts, :kph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.convert(:kts, :kph, SPEED_LIMIT_BRAVO_KTS))
	end
	def test_kph_to_kts
		assert_nil(Metar::Units.kph_to_kts(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.kph_to_kts(SPEED_LIMIT_BRAVO_KPH))

		assert_nil(Metar::Units.convert(:kph, :kts, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.convert(:kph, :kts, SPEED_LIMIT_BRAVO_KPH))
	end

	def test_kts_to_mps
		assert_nil(Metar::Units.kts_to_mps(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.kts_to_mps(SPEED_LIMIT_BRAVO_KTS))

		assert_nil(Metar::Units.convert(:kts, :mps, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.convert(:kts, :mps, SPEED_LIMIT_BRAVO_KTS))
	end
	def test_mps_to_kts
		assert_nil(Metar::Units.mps_to_kts(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.mps_to_kts(SPEED_LIMIT_BRAVO_MPS))

		assert_nil(Metar::Units.convert(:mps, :kts, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.convert(:mps, :kts, SPEED_LIMIT_BRAVO_MPS))
	end
	
	def test_mph_to_kph
		assert_nil(Metar::Units.mph_to_kph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.mph_to_kph(SPEED_LIMIT_BRAVO_MPH))

		assert_nil(Metar::Units.convert(:mph, :kph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.convert(:mph, :kph, SPEED_LIMIT_BRAVO_MPH))
	end
	def test_kph_to_mph
		assert_nil(Metar::Units.kph_to_mph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.kph_to_mph(SPEED_LIMIT_BRAVO_KPH))

		assert_nil(Metar::Units.convert(:kph, :mph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.convert(:kph, :mph, SPEED_LIMIT_BRAVO_KPH))
	end
	
	def test_mph_to_mps
		assert_nil(Metar::Units.mph_to_mps(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.mph_to_mps(SPEED_LIMIT_BRAVO_MPH))

		assert_nil(Metar::Units.convert(:mph, :mps, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.convert(:mph, :mps, SPEED_LIMIT_BRAVO_MPH))
	end
	def test_mps_to_mph
		assert_nil(Metar::Units.mps_to_mph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.mps_to_mph(SPEED_LIMIT_BRAVO_MPS))

		assert_nil(Metar::Units.convert(:kph, :mph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.convert(:mps, :mph, SPEED_LIMIT_BRAVO_MPS))
	end

	def test_kph_to_mps
		assert_nil(Metar::Units.kph_to_mps(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.kph_to_mps(SPEED_LIMIT_BRAVO_KPH))

		assert_nil(Metar::Units.convert(:kph, :mps, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.convert(:kph, :mps, SPEED_LIMIT_BRAVO_KPH))
	end
	def test_mps_to_kph
		assert_nil(Metar::Units.mps_to_kph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.mps_to_kph(SPEED_LIMIT_BRAVO_MPS))

		assert_nil(Metar::Units.convert(:kph, :kph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.convert(:mps, :kph, SPEED_LIMIT_BRAVO_MPS))
	end

	def test_kts_to_kts
		assert_nil(Metar::Units.kts_to_kts(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.kts_to_kts(SPEED_LIMIT_BRAVO_KTS))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.kts_to_kts(SPEED_LIMIT_BRAVO_KTS + 0.00001))

		assert_nil(Metar::Units.convert(:kts, :kts, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.convert(:kts, :kts, SPEED_LIMIT_BRAVO_KTS))
		assert_equal(SPEED_LIMIT_BRAVO_KTS.round(0), Metar::Units.convert(:kts, :kts, SPEED_LIMIT_BRAVO_KTS + 0.00001))
	end
	def test_mph_to_mph
		assert_nil(Metar::Units.mph_to_mph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.mph_to_mph(SPEED_LIMIT_BRAVO_MPH))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.mph_to_mph(SPEED_LIMIT_BRAVO_MPH + 0.00001))

		assert_nil(Metar::Units.convert(:mph, :mph, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.convert(:mph, :mph, SPEED_LIMIT_BRAVO_MPH))
		assert_equal(SPEED_LIMIT_BRAVO_MPH.round(0), Metar::Units.convert(:mph, :mph, SPEED_LIMIT_BRAVO_MPH + 0.00001))
	end
	def test_kph_to_kph
		assert_nil(Metar::Units.kph_to_kph(nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.kph_to_kph(SPEED_LIMIT_BRAVO_KPH))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.kph_to_kph(SPEED_LIMIT_BRAVO_KPH + 0.00001))

		assert_nil(Metar::Units.convert(:kts, :kts, nil))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.convert(:kph, :kph, SPEED_LIMIT_BRAVO_KPH))
		assert_equal(SPEED_LIMIT_BRAVO_KPH.round(0), Metar::Units.convert(:kph, :kph, SPEED_LIMIT_BRAVO_KPH + 0.00001))
	end
	def test_mps_to_mps
		assert_nil(Metar::Units.mps_to_mps(nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.mps_to_mps(SPEED_LIMIT_BRAVO_MPS))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.mps_to_mps(SPEED_LIMIT_BRAVO_MPS + 0.00001))

		assert_nil(Metar::Units.convert(:mps, :mps, nil))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.convert(:mps, :mps, SPEED_LIMIT_BRAVO_MPS))
		assert_equal(SPEED_LIMIT_BRAVO_MPS.round(0), Metar::Units.convert(:mps, :mps, SPEED_LIMIT_BRAVO_MPS + 0.00001))
	end

	
	### Pressure
	STD_PRESSURE_INHG	= 29.92
	STD_PRESSURE_MMHG	= 760.0
	STD_PRESSURE_HPA	= 1013.25
	STD_PRESSURE_MB		= 1013.25

	def test_inhg_to_hpa
		assert_nil(Metar::Units.inhg_to_hpa(nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.inhg_to_hpa(STD_PRESSURE_INHG))

		assert_nil(Metar::Units.convert(:inhg, :hpa, nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.convert(:inhg, :hpa, STD_PRESSURE_INHG))
	end	
	def test_hpa_to_inhg
		assert_nil(Metar::Units.hpa_to_inhg(nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.hpa_to_inhg(STD_PRESSURE_HPA))

		assert_nil(Metar::Units.convert(:hpa, :inhg, nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.convert(:hpa, :inhg, STD_PRESSURE_HPA))
	end
	
	def test_mmhg_to_hpa
		assert_nil(Metar::Units.mmhg_to_hpa(nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.mmhg_to_hpa(STD_PRESSURE_MMHG))

		assert_nil(Metar::Units.convert(:mmhg, :hpa, nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.convert(:mmhg, :hpa, STD_PRESSURE_MMHG))
	end
	def test_hpa_to_mmhg
		assert_nil(Metar::Units.hpa_to_mmhg(nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.hpa_to_mmhg(STD_PRESSURE_HPA))

		assert_nil(Metar::Units.convert(:hpa, :mmhg, nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.convert(:hpa, :mmhg, STD_PRESSURE_HPA))
	end	

	def test_mmhg_to_inhg
		assert_nil(Metar::Units.mmhg_to_inhg(nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.mmhg_to_inhg(STD_PRESSURE_MMHG))

		assert_nil(Metar::Units.convert(:mmhg, :inhg, nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.convert(:mmhg, :inhg, STD_PRESSURE_MMHG))
	end	
	def test_inhg_to_mmhg
		assert_nil(Metar::Units.inhg_to_mmhg(nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.inhg_to_mmhg(STD_PRESSURE_INHG))

		assert_nil(Metar::Units.convert(:inhg, :mmhg, nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.convert(:inhg, :mmhg, STD_PRESSURE_INHG))
	end	
	
	def test_inhg_to_mb
		assert_nil(Metar::Units.inhg_to_mb(nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.inhg_to_mb(STD_PRESSURE_INHG))

		assert_nil(Metar::Units.convert(:inhg, :mb, nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.convert(:inhg, :mb, STD_PRESSURE_INHG))
	end	
	def test_mb_to_inhg
		assert_nil(Metar::Units.mb_to_inhg(nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.mb_to_inhg(STD_PRESSURE_MB))

		assert_nil(Metar::Units.convert(:mb, :inhg, nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.convert(:mb, :inhg, STD_PRESSURE_MB))
	end	
		
	def test_mmhg_to_mb
		assert_nil(Metar::Units.mmhg_to_inhg(nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.mmhg_to_mb(STD_PRESSURE_MMHG))

		assert_nil(Metar::Units.convert(:mmhg, :mb, nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.convert(:mmhg, :mb, STD_PRESSURE_MMHG))
	end	
	def test_mb_to_mmhg
		assert_nil(Metar::Units.mb_to_mmhg(nil))
		assert_equal(STD_PRESSURE_MMHG, Metar::Units.mb_to_mmhg(STD_PRESSURE_MB))

		assert_nil(Metar::Units.convert(:mb, :mmhg, nil))
		assert_equal(STD_PRESSURE_MMHG, Metar::Units.convert(:mb, :mmhg, STD_PRESSURE_MB))
	end	

	def test_hpa_to_mb
		assert_nil(Metar::Units.hpa_to_mb(nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.hpa_to_mb(STD_PRESSURE_HPA))

		assert_nil(Metar::Units.convert(:hpa, :mb, nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.convert(:hpa, :mb, STD_PRESSURE_HPA))
	end	
	def test_mb_to_hpa
		assert_nil(Metar::Units.mb_to_hpa(nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.mb_to_hpa(STD_PRESSURE_MB))

		assert_nil(Metar::Units.convert(:mb, :hpa, nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.convert(:mb, :hpa, STD_PRESSURE_MB))
	end	

	def test_mb_to_mb
		assert_nil(Metar::Units.mb_to_mb(nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.mb_to_mb(STD_PRESSURE_MB))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.mb_to_mb(STD_PRESSURE_MB + 0.00001))

		assert_nil(Metar::Units.convert(:mb, :mb, nil))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.convert(:mb, :mb, STD_PRESSURE_MB))
		assert_equal(STD_PRESSURE_MB.round(0), Metar::Units.convert(:mb, :mb, STD_PRESSURE_MB + 0.00001))
	end	
	def test_hpa_to_hpa
		assert_nil(Metar::Units.hpa_to_hpa(nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.hpa_to_hpa(STD_PRESSURE_HPA))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.hpa_to_hpa(STD_PRESSURE_HPA + 0.00001))

		assert_nil(Metar::Units.convert(:hpa, :hpa, nil))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.convert(:hpa, :hpa, STD_PRESSURE_HPA))
		assert_equal(STD_PRESSURE_HPA.round(0), Metar::Units.convert(:hpa, :hpa, STD_PRESSURE_HPA + 0.00001))
	end
	def test_inhg_to_inhg
		assert_nil(Metar::Units.inhg_to_inhg(nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.inhg_to_inhg(STD_PRESSURE_INHG))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.inhg_to_inhg(STD_PRESSURE_INHG + 0.00001))

		assert_nil(Metar::Units.convert(:inhg, :inhg, nil))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.convert(:inhg, :inhg, STD_PRESSURE_INHG))
		assert_equal(STD_PRESSURE_INHG, Metar::Units.convert(:inhg, :inhg, STD_PRESSURE_INHG + 0.00001))
	end	
	def test_mmhg_to_mmhg
		assert_nil(Metar::Units.mmhg_to_mmhg(nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.mmhg_to_mmhg(STD_PRESSURE_MMHG))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.mmhg_to_mmhg(STD_PRESSURE_MMHG + 0.00001))

		assert_nil(Metar::Units.convert(:mmhg, :mmhg, nil))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.convert(:mmhg, :mmhg, STD_PRESSURE_MMHG))
		assert_equal(STD_PRESSURE_MMHG.round(0), Metar::Units.convert(:mmhg, :mmhg, STD_PRESSURE_MMHG + 0.00001))
	end
	
	
	### Distance
	MODEC_VEIL_FT	= 182283.0
	MODEC_VEIL_M	= 55560.0
	MODEC_VEIL_KM	= 55.56
	MODEC_VEIL_SM	= 34.5233834
	MODEC_VEIL_NM	= 30.0
	
	def test_ft_to_m
		assert_nil(Metar::Units.ft_to_m(nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.ft_to_m(MODEC_VEIL_FT))

		assert_nil(Metar::Units.convert(:ft, :m, nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:ft, :m, MODEC_VEIL_FT))
	end
	def test_m_to_ft
		assert_nil(Metar::Units.m_to_ft(nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.m_to_ft(MODEC_VEIL_M))

		assert_nil(Metar::Units.convert(:m, :ft, nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:m, :ft, MODEC_VEIL_M))
	end

	def test_ft_to_km
		assert_nil(Metar::Units.ft_to_km(nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.ft_to_km(MODEC_VEIL_FT))

		assert_nil(Metar::Units.convert(:ft, :km, nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:ft, :km, MODEC_VEIL_FT))
	end
	def test_km_to_ft
		assert_nil(Metar::Units.km_to_ft(nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.km_to_ft(MODEC_VEIL_KM))

		assert_nil(Metar::Units.convert(:km, :ft, nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:km, :ft, MODEC_VEIL_KM))
	end

	def test_ft_to_sm
		assert_nil(Metar::Units.ft_to_sm(nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.ft_to_sm(MODEC_VEIL_FT))

		assert_nil(Metar::Units.convert(:ft, :sm, nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.convert(:ft, :sm, MODEC_VEIL_FT))
	end
	def test_sm_to_ft
		assert_nil(Metar::Units.sm_to_ft(nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.sm_to_ft(MODEC_VEIL_SM))

		assert_nil(Metar::Units.convert(:sm, :ft, nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:sm, :ft, MODEC_VEIL_SM))
	end

	def test_ft_to_nm
		assert_nil(Metar::Units.ft_to_nm(nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.ft_to_nm(MODEC_VEIL_FT))

		assert_nil(Metar::Units.convert(:ft, :nm, nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.convert(:ft, :nm, MODEC_VEIL_FT))
	end
	def test_nm_to_ft
		assert_nil(Metar::Units.nm_to_ft(nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.nm_to_ft(MODEC_VEIL_NM))

		assert_nil(Metar::Units.convert(:nm, :ft, nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:nm, :ft, MODEC_VEIL_NM))
	end

	def test_m_to_km
		assert_nil(Metar::Units.m_to_km(nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.m_to_km(MODEC_VEIL_M))

		assert_nil(Metar::Units.convert(:m, :km, nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:m, :km, MODEC_VEIL_M))
	end
	def test_km_to_m
		assert_nil(Metar::Units.km_to_m(nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.km_to_m(MODEC_VEIL_KM))

		assert_nil(Metar::Units.convert(:km, :m, nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:km, :m, MODEC_VEIL_KM))
	end

	def test_m_to_sm
		assert_nil(Metar::Units.m_to_sm(nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.m_to_sm(MODEC_VEIL_M))

		assert_nil(Metar::Units.convert(:m, :sm, nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.convert(:m, :sm, MODEC_VEIL_M))
	end
	def test_sm_to_m
		assert_nil(Metar::Units.sm_to_m(nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.sm_to_m(MODEC_VEIL_SM))

		assert_nil(Metar::Units.convert(:sm, :m, nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:sm, :m, MODEC_VEIL_SM))
	end

	def test_m_to_nm
		assert_nil(Metar::Units.m_to_nm(nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.m_to_nm(MODEC_VEIL_M))

		assert_nil(Metar::Units.convert(:m, :nm, nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.convert(:m, :nm, MODEC_VEIL_M))
	end
	def test_nm_to_m
		assert_nil(Metar::Units.nm_to_m(nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.nm_to_m(MODEC_VEIL_NM))

		assert_nil(Metar::Units.convert(:nm, :m, nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:nm, :m, MODEC_VEIL_NM))
	end

	def test_km_to_sm
		assert_nil(Metar::Units.km_to_sm(nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.km_to_sm(MODEC_VEIL_KM))

		assert_nil(Metar::Units.convert(:km, :sm, nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.convert(:km, :sm, MODEC_VEIL_KM))
	end
	def test_sm_to_km
		assert_nil(Metar::Units.sm_to_km(nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.sm_to_km(MODEC_VEIL_SM))

		assert_nil(Metar::Units.convert(:sm, :km, nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:sm, :km, MODEC_VEIL_SM))
	end

	def test_km_to_nm
		assert_nil(Metar::Units.km_to_nm(nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.km_to_nm(MODEC_VEIL_KM))

		assert_nil(Metar::Units.convert(:km, :nm, nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.convert(:km, :nm, MODEC_VEIL_KM))
	end
	def test_nm_to_km
		assert_nil(Metar::Units.nm_to_km(nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.nm_to_km(MODEC_VEIL_NM))

		assert_nil(Metar::Units.convert(:nm, :km, nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:nm, :km, MODEC_VEIL_NM))
	end

	def test_sm_to_nm
	end
	def test_nm_to_sm
	end

	def test_ft_to_ft
		assert_nil(Metar::Units.ft_to_ft(nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.ft_to_ft(MODEC_VEIL_FT))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.ft_to_ft(MODEC_VEIL_FT + 0.00001))

		assert_nil(Metar::Units.convert(:ft, :ft, nil))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:ft, :ft, MODEC_VEIL_FT))
		assert_equal(MODEC_VEIL_FT.round(0), Metar::Units.convert(:ft, :ft, MODEC_VEIL_FT + 0.00001))
	end
	def test_m_to_m
		assert_nil(Metar::Units.m_to_m(nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.m_to_m(MODEC_VEIL_M))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.m_to_m(MODEC_VEIL_M + 0.00001))

		assert_nil(Metar::Units.convert(:m, :m, nil))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:m, :m, MODEC_VEIL_M))
		assert_equal(MODEC_VEIL_M.round(0), Metar::Units.convert(:m, :m, MODEC_VEIL_M + 0.00001))
	end
	def test_km_to_km
		assert_nil(Metar::Units.km_to_km(nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.km_to_km(MODEC_VEIL_KM))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.km_to_km(MODEC_VEIL_KM + 0.00001))

		assert_nil(Metar::Units.convert(:km, :km, nil))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:km, :km, MODEC_VEIL_KM))
		assert_equal(MODEC_VEIL_KM.round(0), Metar::Units.convert(:km, :km, MODEC_VEIL_KM + 0.00001))
	end
	def test_sm_to_sm
		assert_nil(Metar::Units.sm_to_sm(nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.sm_to_sm(MODEC_VEIL_SM))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.sm_to_sm(MODEC_VEIL_SM + 0.00001))

		assert_nil(Metar::Units.convert(:sm, :sm, nil))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.convert(:sm, :sm, MODEC_VEIL_SM))
		assert_equal(MODEC_VEIL_SM.round(0), Metar::Units.convert(:sm, :sm, MODEC_VEIL_SM + 0.00001))
	end
	def test_nm_to_nm
		assert_nil(Metar::Units.nm_to_nm(nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.nm_to_nm(MODEC_VEIL_NM))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.nm_to_nm(MODEC_VEIL_NM + 0.00001))

		assert_nil(Metar::Units.convert(:nm, :nm, nil))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.convert(:nm, :nm, MODEC_VEIL_NM))
		assert_equal(MODEC_VEIL_NM.round(0), Metar::Units.convert(:nm, :nm, MODEC_VEIL_NM + 0.00001))
	end
end