// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'day_weather_conditions.dart';

class DayWeatherConditionsMapper extends ClassMapperBase<DayWeatherConditions> {
  DayWeatherConditionsMapper._();

  static DayWeatherConditionsMapper? _instance;
  static DayWeatherConditionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DayWeatherConditionsMapper._());
      DayPartForecastMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'DayWeatherConditions';

  static String _$conditionCode(DayWeatherConditions v) => v.conditionCode;
  static const Field<DayWeatherConditions, String> _f$conditionCode =
      Field('conditionCode', _$conditionCode);
  static DateTime _$forecastStart(DayWeatherConditions v) => v.forecastStart;
  static const Field<DayWeatherConditions, DateTime> _f$forecastStart =
      Field('forecastStart', _$forecastStart);
  static DateTime _$forecastEnd(DayWeatherConditions v) => v.forecastEnd;
  static const Field<DayWeatherConditions, DateTime> _f$forecastEnd =
      Field('forecastEnd', _$forecastEnd);
  static int _$maxUvIndex(DayWeatherConditions v) => v.maxUvIndex;
  static const Field<DayWeatherConditions, int> _f$maxUvIndex =
      Field('maxUvIndex', _$maxUvIndex);
  static String _$moonPhase(DayWeatherConditions v) => v.moonPhase;
  static const Field<DayWeatherConditions, String> _f$moonPhase =
      Field('moonPhase', _$moonPhase);
  static DateTime? _$moonrise(DayWeatherConditions v) => v.moonrise;
  static const Field<DayWeatherConditions, DateTime> _f$moonrise =
      Field('moonrise', _$moonrise);
  static DateTime? _$moonset(DayWeatherConditions v) => v.moonset;
  static const Field<DayWeatherConditions, DateTime> _f$moonset =
      Field('moonset', _$moonset);
  static DayPartForecast? _$daytimeForecast(DayWeatherConditions v) =>
      v.daytimeForecast;
  static const Field<DayWeatherConditions, DayPartForecast> _f$daytimeForecast =
      Field('daytimeForecast', _$daytimeForecast);
  static DayPartForecast? _$overnightForecast(DayWeatherConditions v) =>
      v.overnightForecast;
  static const Field<DayWeatherConditions, DayPartForecast>
      _f$overnightForecast = Field('overnightForecast', _$overnightForecast);
  static num _$precipitationAmount(DayWeatherConditions v) =>
      v.precipitationAmount;
  static const Field<DayWeatherConditions, num> _f$precipitationAmount =
      Field('precipitationAmount', _$precipitationAmount);
  static num _$precipitationChance(DayWeatherConditions v) =>
      v.precipitationChance;
  static const Field<DayWeatherConditions, num> _f$precipitationChance =
      Field('precipitationChance', _$precipitationChance);
  static String _$precipitationType(DayWeatherConditions v) =>
      v.precipitationType;
  static const Field<DayWeatherConditions, String> _f$precipitationType =
      Field('precipitationType', _$precipitationType);
  static num _$snowfallAmount(DayWeatherConditions v) => v.snowfallAmount;
  static const Field<DayWeatherConditions, num> _f$snowfallAmount =
      Field('snowfallAmount', _$snowfallAmount);
  static DateTime? _$solarMidnight(DayWeatherConditions v) => v.solarMidnight;
  static const Field<DayWeatherConditions, DateTime> _f$solarMidnight =
      Field('solarMidnight', _$solarMidnight);
  static DateTime? _$solarNoon(DayWeatherConditions v) => v.solarNoon;
  static const Field<DayWeatherConditions, DateTime> _f$solarNoon =
      Field('solarNoon', _$solarNoon);
  static DateTime? _$sunrise(DayWeatherConditions v) => v.sunrise;
  static const Field<DayWeatherConditions, DateTime> _f$sunrise =
      Field('sunrise', _$sunrise);
  static DateTime? _$sunriseAstronomical(DayWeatherConditions v) =>
      v.sunriseAstronomical;
  static const Field<DayWeatherConditions, DateTime> _f$sunriseAstronomical =
      Field('sunriseAstronomical', _$sunriseAstronomical);
  static DateTime? _$sunriseCivil(DayWeatherConditions v) => v.sunriseCivil;
  static const Field<DayWeatherConditions, DateTime> _f$sunriseCivil =
      Field('sunriseCivil', _$sunriseCivil);
  static DateTime? _$sunriseNautical(DayWeatherConditions v) =>
      v.sunriseNautical;
  static const Field<DayWeatherConditions, DateTime> _f$sunriseNautical =
      Field('sunriseNautical', _$sunriseNautical);
  static DateTime? _$sunset(DayWeatherConditions v) => v.sunset;
  static const Field<DayWeatherConditions, DateTime> _f$sunset =
      Field('sunset', _$sunset);
  static DateTime? _$sunsetAstronomical(DayWeatherConditions v) =>
      v.sunsetAstronomical;
  static const Field<DayWeatherConditions, DateTime> _f$sunsetAstronomical =
      Field('sunsetAstronomical', _$sunsetAstronomical);
  static DateTime? _$sunsetCivil(DayWeatherConditions v) => v.sunsetCivil;
  static const Field<DayWeatherConditions, DateTime> _f$sunsetCivil =
      Field('sunsetCivil', _$sunsetCivil);
  static DateTime? _$sunsetNautical(DayWeatherConditions v) => v.sunsetNautical;
  static const Field<DayWeatherConditions, DateTime> _f$sunsetNautical =
      Field('sunsetNautical', _$sunsetNautical);
  static num _$temperatureMax(DayWeatherConditions v) => v.temperatureMax;
  static const Field<DayWeatherConditions, num> _f$temperatureMax =
      Field('temperatureMax', _$temperatureMax);
  static num _$temperatureMin(DayWeatherConditions v) => v.temperatureMin;
  static const Field<DayWeatherConditions, num> _f$temperatureMin =
      Field('temperatureMin', _$temperatureMin);

  @override
  final Map<Symbol, Field<DayWeatherConditions, dynamic>> fields = const {
    #conditionCode: _f$conditionCode,
    #forecastStart: _f$forecastStart,
    #forecastEnd: _f$forecastEnd,
    #maxUvIndex: _f$maxUvIndex,
    #moonPhase: _f$moonPhase,
    #moonrise: _f$moonrise,
    #moonset: _f$moonset,
    #daytimeForecast: _f$daytimeForecast,
    #overnightForecast: _f$overnightForecast,
    #precipitationAmount: _f$precipitationAmount,
    #precipitationChance: _f$precipitationChance,
    #precipitationType: _f$precipitationType,
    #snowfallAmount: _f$snowfallAmount,
    #solarMidnight: _f$solarMidnight,
    #solarNoon: _f$solarNoon,
    #sunrise: _f$sunrise,
    #sunriseAstronomical: _f$sunriseAstronomical,
    #sunriseCivil: _f$sunriseCivil,
    #sunriseNautical: _f$sunriseNautical,
    #sunset: _f$sunset,
    #sunsetAstronomical: _f$sunsetAstronomical,
    #sunsetCivil: _f$sunsetCivil,
    #sunsetNautical: _f$sunsetNautical,
    #temperatureMax: _f$temperatureMax,
    #temperatureMin: _f$temperatureMin,
  };

  static DayWeatherConditions _instantiate(DecodingData data) {
    return DayWeatherConditions(
        conditionCode: data.dec(_f$conditionCode),
        forecastStart: data.dec(_f$forecastStart),
        forecastEnd: data.dec(_f$forecastEnd),
        maxUvIndex: data.dec(_f$maxUvIndex),
        moonPhase: data.dec(_f$moonPhase),
        moonrise: data.dec(_f$moonrise),
        moonset: data.dec(_f$moonset),
        daytimeForecast: data.dec(_f$daytimeForecast),
        overnightForecast: data.dec(_f$overnightForecast),
        precipitationAmount: data.dec(_f$precipitationAmount),
        precipitationChance: data.dec(_f$precipitationChance),
        precipitationType: data.dec(_f$precipitationType),
        snowfallAmount: data.dec(_f$snowfallAmount),
        solarMidnight: data.dec(_f$solarMidnight),
        solarNoon: data.dec(_f$solarNoon),
        sunrise: data.dec(_f$sunrise),
        sunriseAstronomical: data.dec(_f$sunriseAstronomical),
        sunriseCivil: data.dec(_f$sunriseCivil),
        sunriseNautical: data.dec(_f$sunriseNautical),
        sunset: data.dec(_f$sunset),
        sunsetAstronomical: data.dec(_f$sunsetAstronomical),
        sunsetCivil: data.dec(_f$sunsetCivil),
        sunsetNautical: data.dec(_f$sunsetNautical),
        temperatureMax: data.dec(_f$temperatureMax),
        temperatureMin: data.dec(_f$temperatureMin));
  }

  @override
  final Function instantiate = _instantiate;

  static DayWeatherConditions fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<DayWeatherConditions>(map));
  }

  static DayWeatherConditions fromJson(String json) {
    return _guard((c) => c.fromJson<DayWeatherConditions>(json));
  }
}

mixin DayWeatherConditionsMappable {
  String toJson() {
    return DayWeatherConditionsMapper._guard(
        (c) => c.toJson(this as DayWeatherConditions));
  }

  Map<String, dynamic> toMap() {
    return DayWeatherConditionsMapper._guard(
        (c) => c.toMap(this as DayWeatherConditions));
  }

  DayWeatherConditionsCopyWith<DayWeatherConditions, DayWeatherConditions,
          DayWeatherConditions>
      get copyWith => _DayWeatherConditionsCopyWithImpl(
          this as DayWeatherConditions, $identity, $identity);
  @override
  String toString() {
    return DayWeatherConditionsMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DayWeatherConditionsMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return DayWeatherConditionsMapper._guard((c) => c.hash(this));
  }
}

extension DayWeatherConditionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DayWeatherConditions, $Out> {
  DayWeatherConditionsCopyWith<$R, DayWeatherConditions, $Out>
      get $asDayWeatherConditions =>
          $base.as((v, t, t2) => _DayWeatherConditionsCopyWithImpl(v, t, t2));
}

abstract class DayWeatherConditionsCopyWith<
    $R,
    $In extends DayWeatherConditions,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  DayPartForecastCopyWith<$R, DayPartForecast, DayPartForecast>?
      get daytimeForecast;
  DayPartForecastCopyWith<$R, DayPartForecast, DayPartForecast>?
      get overnightForecast;
  $R call(
      {String? conditionCode,
      DateTime? forecastStart,
      DateTime? forecastEnd,
      int? maxUvIndex,
      String? moonPhase,
      DateTime? moonrise,
      DateTime? moonset,
      DayPartForecast? daytimeForecast,
      DayPartForecast? overnightForecast,
      num? precipitationAmount,
      num? precipitationChance,
      String? precipitationType,
      num? snowfallAmount,
      DateTime? solarMidnight,
      DateTime? solarNoon,
      DateTime? sunrise,
      DateTime? sunriseAstronomical,
      DateTime? sunriseCivil,
      DateTime? sunriseNautical,
      DateTime? sunset,
      DateTime? sunsetAstronomical,
      DateTime? sunsetCivil,
      DateTime? sunsetNautical,
      num? temperatureMax,
      num? temperatureMin});
  DayWeatherConditionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DayWeatherConditionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DayWeatherConditions, $Out>
    implements DayWeatherConditionsCopyWith<$R, DayWeatherConditions, $Out> {
  _DayWeatherConditionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DayWeatherConditions> $mapper =
      DayWeatherConditionsMapper.ensureInitialized();
  @override
  DayPartForecastCopyWith<$R, DayPartForecast, DayPartForecast>?
      get daytimeForecast => $value.daytimeForecast?.copyWith
          .$chain((v) => call(daytimeForecast: v));
  @override
  DayPartForecastCopyWith<$R, DayPartForecast, DayPartForecast>?
      get overnightForecast => $value.overnightForecast?.copyWith
          .$chain((v) => call(overnightForecast: v));
  @override
  $R call(
          {String? conditionCode,
          DateTime? forecastStart,
          DateTime? forecastEnd,
          int? maxUvIndex,
          String? moonPhase,
          Object? moonrise = $none,
          Object? moonset = $none,
          Object? daytimeForecast = $none,
          Object? overnightForecast = $none,
          num? precipitationAmount,
          num? precipitationChance,
          String? precipitationType,
          num? snowfallAmount,
          Object? solarMidnight = $none,
          Object? solarNoon = $none,
          Object? sunrise = $none,
          Object? sunriseAstronomical = $none,
          Object? sunriseCivil = $none,
          Object? sunriseNautical = $none,
          Object? sunset = $none,
          Object? sunsetAstronomical = $none,
          Object? sunsetCivil = $none,
          Object? sunsetNautical = $none,
          num? temperatureMax,
          num? temperatureMin}) =>
      $apply(FieldCopyWithData({
        if (conditionCode != null) #conditionCode: conditionCode,
        if (forecastStart != null) #forecastStart: forecastStart,
        if (forecastEnd != null) #forecastEnd: forecastEnd,
        if (maxUvIndex != null) #maxUvIndex: maxUvIndex,
        if (moonPhase != null) #moonPhase: moonPhase,
        if (moonrise != $none) #moonrise: moonrise,
        if (moonset != $none) #moonset: moonset,
        if (daytimeForecast != $none) #daytimeForecast: daytimeForecast,
        if (overnightForecast != $none) #overnightForecast: overnightForecast,
        if (precipitationAmount != null)
          #precipitationAmount: precipitationAmount,
        if (precipitationChance != null)
          #precipitationChance: precipitationChance,
        if (precipitationType != null) #precipitationType: precipitationType,
        if (snowfallAmount != null) #snowfallAmount: snowfallAmount,
        if (solarMidnight != $none) #solarMidnight: solarMidnight,
        if (solarNoon != $none) #solarNoon: solarNoon,
        if (sunrise != $none) #sunrise: sunrise,
        if (sunriseAstronomical != $none)
          #sunriseAstronomical: sunriseAstronomical,
        if (sunriseCivil != $none) #sunriseCivil: sunriseCivil,
        if (sunriseNautical != $none) #sunriseNautical: sunriseNautical,
        if (sunset != $none) #sunset: sunset,
        if (sunsetAstronomical != $none)
          #sunsetAstronomical: sunsetAstronomical,
        if (sunsetCivil != $none) #sunsetCivil: sunsetCivil,
        if (sunsetNautical != $none) #sunsetNautical: sunsetNautical,
        if (temperatureMax != null) #temperatureMax: temperatureMax,
        if (temperatureMin != null) #temperatureMin: temperatureMin
      }));
  @override
  DayWeatherConditions $make(CopyWithData data) => DayWeatherConditions(
      conditionCode: data.get(#conditionCode, or: $value.conditionCode),
      forecastStart: data.get(#forecastStart, or: $value.forecastStart),
      forecastEnd: data.get(#forecastEnd, or: $value.forecastEnd),
      maxUvIndex: data.get(#maxUvIndex, or: $value.maxUvIndex),
      moonPhase: data.get(#moonPhase, or: $value.moonPhase),
      moonrise: data.get(#moonrise, or: $value.moonrise),
      moonset: data.get(#moonset, or: $value.moonset),
      daytimeForecast: data.get(#daytimeForecast, or: $value.daytimeForecast),
      overnightForecast:
          data.get(#overnightForecast, or: $value.overnightForecast),
      precipitationAmount:
          data.get(#precipitationAmount, or: $value.precipitationAmount),
      precipitationChance:
          data.get(#precipitationChance, or: $value.precipitationChance),
      precipitationType:
          data.get(#precipitationType, or: $value.precipitationType),
      snowfallAmount: data.get(#snowfallAmount, or: $value.snowfallAmount),
      solarMidnight: data.get(#solarMidnight, or: $value.solarMidnight),
      solarNoon: data.get(#solarNoon, or: $value.solarNoon),
      sunrise: data.get(#sunrise, or: $value.sunrise),
      sunriseAstronomical:
          data.get(#sunriseAstronomical, or: $value.sunriseAstronomical),
      sunriseCivil: data.get(#sunriseCivil, or: $value.sunriseCivil),
      sunriseNautical: data.get(#sunriseNautical, or: $value.sunriseNautical),
      sunset: data.get(#sunset, or: $value.sunset),
      sunsetAstronomical:
          data.get(#sunsetAstronomical, or: $value.sunsetAstronomical),
      sunsetCivil: data.get(#sunsetCivil, or: $value.sunsetCivil),
      sunsetNautical: data.get(#sunsetNautical, or: $value.sunsetNautical),
      temperatureMax: data.get(#temperatureMax, or: $value.temperatureMax),
      temperatureMin: data.get(#temperatureMin, or: $value.temperatureMin));

  @override
  DayWeatherConditionsCopyWith<$R2, DayWeatherConditions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DayWeatherConditionsCopyWithImpl($value, $cast, t);
}
