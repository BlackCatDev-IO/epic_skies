// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'hour_weather_conditions.dart';

class HourWeatherConditionsMapper
    extends ClassMapperBase<HourWeatherConditions> {
  HourWeatherConditionsMapper._();

  static HourWeatherConditionsMapper? _instance;
  static HourWeatherConditionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HourWeatherConditionsMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'HourWeatherConditions';

  static num _$cloudCover(HourWeatherConditions v) => v.cloudCover;
  static const Field<HourWeatherConditions, num> _f$cloudCover =
      Field('cloudCover', _$cloudCover);
  static String _$conditionCode(HourWeatherConditions v) => v.conditionCode;
  static const Field<HourWeatherConditions, String> _f$conditionCode =
      Field('conditionCode', _$conditionCode);
  static bool? _$daylight(HourWeatherConditions v) => v.daylight;
  static const Field<HourWeatherConditions, bool> _f$daylight =
      Field('daylight', _$daylight);
  static DateTime _$forecastStart(HourWeatherConditions v) => v.forecastStart;
  static const Field<HourWeatherConditions, DateTime> _f$forecastStart =
      Field('forecastStart', _$forecastStart);
  static num _$humidity(HourWeatherConditions v) => v.humidity;
  static const Field<HourWeatherConditions, num> _f$humidity =
      Field('humidity', _$humidity);
  static num _$precipitationChance(HourWeatherConditions v) =>
      v.precipitationChance;
  static const Field<HourWeatherConditions, num> _f$precipitationChance =
      Field('precipitationChance', _$precipitationChance);
  static String _$precipitationType(HourWeatherConditions v) =>
      v.precipitationType;
  static const Field<HourWeatherConditions, String> _f$precipitationType =
      Field('precipitationType', _$precipitationType);
  static num _$pressure(HourWeatherConditions v) => v.pressure;
  static const Field<HourWeatherConditions, num> _f$pressure =
      Field('pressure', _$pressure);
  static String? _$pressureTrend(HourWeatherConditions v) => v.pressureTrend;
  static const Field<HourWeatherConditions, String> _f$pressureTrend =
      Field('pressureTrend', _$pressureTrend);
  static num? _$snowfallIntensity(HourWeatherConditions v) =>
      v.snowfallIntensity;
  static const Field<HourWeatherConditions, num> _f$snowfallIntensity =
      Field('snowfallIntensity', _$snowfallIntensity);
  static num _$temperature(HourWeatherConditions v) => v.temperature;
  static const Field<HourWeatherConditions, num> _f$temperature =
      Field('temperature', _$temperature);
  static num _$temperatureApparent(HourWeatherConditions v) =>
      v.temperatureApparent;
  static const Field<HourWeatherConditions, num> _f$temperatureApparent =
      Field('temperatureApparent', _$temperatureApparent);
  static num? _$temperatureDewPoint(HourWeatherConditions v) =>
      v.temperatureDewPoint;
  static const Field<HourWeatherConditions, num> _f$temperatureDewPoint =
      Field('temperatureDewPoint', _$temperatureDewPoint);
  static int _$uvIndex(HourWeatherConditions v) => v.uvIndex;
  static const Field<HourWeatherConditions, int> _f$uvIndex =
      Field('uvIndex', _$uvIndex);
  static num _$visibility(HourWeatherConditions v) => v.visibility;
  static const Field<HourWeatherConditions, num> _f$visibility =
      Field('visibility', _$visibility);
  static int? _$windDirection(HourWeatherConditions v) => v.windDirection;
  static const Field<HourWeatherConditions, int> _f$windDirection =
      Field('windDirection', _$windDirection);
  static num? _$windGust(HourWeatherConditions v) => v.windGust;
  static const Field<HourWeatherConditions, num> _f$windGust =
      Field('windGust', _$windGust);
  static num _$windSpeed(HourWeatherConditions v) => v.windSpeed;
  static const Field<HourWeatherConditions, num> _f$windSpeed =
      Field('windSpeed', _$windSpeed);
  static num? _$precipitationAmount(HourWeatherConditions v) =>
      v.precipitationAmount;
  static const Field<HourWeatherConditions, num> _f$precipitationAmount =
      Field('precipitationAmount', _$precipitationAmount);

  @override
  final Map<Symbol, Field<HourWeatherConditions, dynamic>> fields = const {
    #cloudCover: _f$cloudCover,
    #conditionCode: _f$conditionCode,
    #daylight: _f$daylight,
    #forecastStart: _f$forecastStart,
    #humidity: _f$humidity,
    #precipitationChance: _f$precipitationChance,
    #precipitationType: _f$precipitationType,
    #pressure: _f$pressure,
    #pressureTrend: _f$pressureTrend,
    #snowfallIntensity: _f$snowfallIntensity,
    #temperature: _f$temperature,
    #temperatureApparent: _f$temperatureApparent,
    #temperatureDewPoint: _f$temperatureDewPoint,
    #uvIndex: _f$uvIndex,
    #visibility: _f$visibility,
    #windDirection: _f$windDirection,
    #windGust: _f$windGust,
    #windSpeed: _f$windSpeed,
    #precipitationAmount: _f$precipitationAmount,
  };

  static HourWeatherConditions _instantiate(DecodingData data) {
    return HourWeatherConditions(
        cloudCover: data.dec(_f$cloudCover),
        conditionCode: data.dec(_f$conditionCode),
        daylight: data.dec(_f$daylight),
        forecastStart: data.dec(_f$forecastStart),
        humidity: data.dec(_f$humidity),
        precipitationChance: data.dec(_f$precipitationChance),
        precipitationType: data.dec(_f$precipitationType),
        pressure: data.dec(_f$pressure),
        pressureTrend: data.dec(_f$pressureTrend),
        snowfallIntensity: data.dec(_f$snowfallIntensity),
        temperature: data.dec(_f$temperature),
        temperatureApparent: data.dec(_f$temperatureApparent),
        temperatureDewPoint: data.dec(_f$temperatureDewPoint),
        uvIndex: data.dec(_f$uvIndex),
        visibility: data.dec(_f$visibility),
        windDirection: data.dec(_f$windDirection),
        windGust: data.dec(_f$windGust),
        windSpeed: data.dec(_f$windSpeed),
        precipitationAmount: data.dec(_f$precipitationAmount));
  }

  @override
  final Function instantiate = _instantiate;

  static HourWeatherConditions fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<HourWeatherConditions>(map));
  }

  static HourWeatherConditions fromJson(String json) {
    return _guard((c) => c.fromJson<HourWeatherConditions>(json));
  }
}

mixin HourWeatherConditionsMappable {
  String toJson() {
    return HourWeatherConditionsMapper._guard(
        (c) => c.toJson(this as HourWeatherConditions));
  }

  Map<String, dynamic> toMap() {
    return HourWeatherConditionsMapper._guard(
        (c) => c.toMap(this as HourWeatherConditions));
  }

  HourWeatherConditionsCopyWith<HourWeatherConditions, HourWeatherConditions,
          HourWeatherConditions>
      get copyWith => _HourWeatherConditionsCopyWithImpl(
          this as HourWeatherConditions, $identity, $identity);
  @override
  String toString() {
    return HourWeatherConditionsMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            HourWeatherConditionsMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return HourWeatherConditionsMapper._guard((c) => c.hash(this));
  }
}

extension HourWeatherConditionsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HourWeatherConditions, $Out> {
  HourWeatherConditionsCopyWith<$R, HourWeatherConditions, $Out>
      get $asHourWeatherConditions =>
          $base.as((v, t, t2) => _HourWeatherConditionsCopyWithImpl(v, t, t2));
}

abstract class HourWeatherConditionsCopyWith<
    $R,
    $In extends HourWeatherConditions,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {num? cloudCover,
      String? conditionCode,
      bool? daylight,
      DateTime? forecastStart,
      num? humidity,
      num? precipitationChance,
      String? precipitationType,
      num? pressure,
      String? pressureTrend,
      num? snowfallIntensity,
      num? temperature,
      num? temperatureApparent,
      num? temperatureDewPoint,
      int? uvIndex,
      num? visibility,
      int? windDirection,
      num? windGust,
      num? windSpeed,
      num? precipitationAmount});
  HourWeatherConditionsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HourWeatherConditionsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HourWeatherConditions, $Out>
    implements HourWeatherConditionsCopyWith<$R, HourWeatherConditions, $Out> {
  _HourWeatherConditionsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HourWeatherConditions> $mapper =
      HourWeatherConditionsMapper.ensureInitialized();
  @override
  $R call(
          {num? cloudCover,
          String? conditionCode,
          Object? daylight = $none,
          DateTime? forecastStart,
          num? humidity,
          num? precipitationChance,
          String? precipitationType,
          num? pressure,
          Object? pressureTrend = $none,
          Object? snowfallIntensity = $none,
          num? temperature,
          num? temperatureApparent,
          Object? temperatureDewPoint = $none,
          int? uvIndex,
          num? visibility,
          Object? windDirection = $none,
          Object? windGust = $none,
          num? windSpeed,
          Object? precipitationAmount = $none}) =>
      $apply(FieldCopyWithData({
        if (cloudCover != null) #cloudCover: cloudCover,
        if (conditionCode != null) #conditionCode: conditionCode,
        if (daylight != $none) #daylight: daylight,
        if (forecastStart != null) #forecastStart: forecastStart,
        if (humidity != null) #humidity: humidity,
        if (precipitationChance != null)
          #precipitationChance: precipitationChance,
        if (precipitationType != null) #precipitationType: precipitationType,
        if (pressure != null) #pressure: pressure,
        if (pressureTrend != $none) #pressureTrend: pressureTrend,
        if (snowfallIntensity != $none) #snowfallIntensity: snowfallIntensity,
        if (temperature != null) #temperature: temperature,
        if (temperatureApparent != null)
          #temperatureApparent: temperatureApparent,
        if (temperatureDewPoint != $none)
          #temperatureDewPoint: temperatureDewPoint,
        if (uvIndex != null) #uvIndex: uvIndex,
        if (visibility != null) #visibility: visibility,
        if (windDirection != $none) #windDirection: windDirection,
        if (windGust != $none) #windGust: windGust,
        if (windSpeed != null) #windSpeed: windSpeed,
        if (precipitationAmount != $none)
          #precipitationAmount: precipitationAmount
      }));
  @override
  HourWeatherConditions $make(CopyWithData data) => HourWeatherConditions(
      cloudCover: data.get(#cloudCover, or: $value.cloudCover),
      conditionCode: data.get(#conditionCode, or: $value.conditionCode),
      daylight: data.get(#daylight, or: $value.daylight),
      forecastStart: data.get(#forecastStart, or: $value.forecastStart),
      humidity: data.get(#humidity, or: $value.humidity),
      precipitationChance:
          data.get(#precipitationChance, or: $value.precipitationChance),
      precipitationType:
          data.get(#precipitationType, or: $value.precipitationType),
      pressure: data.get(#pressure, or: $value.pressure),
      pressureTrend: data.get(#pressureTrend, or: $value.pressureTrend),
      snowfallIntensity:
          data.get(#snowfallIntensity, or: $value.snowfallIntensity),
      temperature: data.get(#temperature, or: $value.temperature),
      temperatureApparent:
          data.get(#temperatureApparent, or: $value.temperatureApparent),
      temperatureDewPoint:
          data.get(#temperatureDewPoint, or: $value.temperatureDewPoint),
      uvIndex: data.get(#uvIndex, or: $value.uvIndex),
      visibility: data.get(#visibility, or: $value.visibility),
      windDirection: data.get(#windDirection, or: $value.windDirection),
      windGust: data.get(#windGust, or: $value.windGust),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed),
      precipitationAmount:
          data.get(#precipitationAmount, or: $value.precipitationAmount));

  @override
  HourWeatherConditionsCopyWith<$R2, HourWeatherConditions, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HourWeatherConditionsCopyWithImpl($value, $cast, t);
}
