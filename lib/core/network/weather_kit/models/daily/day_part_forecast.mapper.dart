// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'day_part_forecast.dart';

class DayPartForecastMapper extends ClassMapperBase<DayPartForecast> {
  DayPartForecastMapper._();

  static DayPartForecastMapper? _instance;
  static DayPartForecastMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DayPartForecastMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DayPartForecast';

  static num? _$cloudCover(DayPartForecast v) => v.cloudCover;
  static const Field<DayPartForecast, num> _f$cloudCover =
      Field('cloudCover', _$cloudCover);
  static String _$conditionCode(DayPartForecast v) => v.conditionCode;
  static const Field<DayPartForecast, String> _f$conditionCode =
      Field('conditionCode', _$conditionCode);
  static DateTime? _$forecastEnd(DayPartForecast v) => v.forecastEnd;
  static const Field<DayPartForecast, DateTime> _f$forecastEnd =
      Field('forecastEnd', _$forecastEnd);
  static DateTime _$forecastStart(DayPartForecast v) => v.forecastStart;
  static const Field<DayPartForecast, DateTime> _f$forecastStart =
      Field('forecastStart', _$forecastStart);
  static num _$humidity(DayPartForecast v) => v.humidity;
  static const Field<DayPartForecast, num> _f$humidity =
      Field('humidity', _$humidity);
  static num _$precipitationAmount(DayPartForecast v) => v.precipitationAmount;
  static const Field<DayPartForecast, num> _f$precipitationAmount =
      Field('precipitationAmount', _$precipitationAmount);
  static num _$precipitationChance(DayPartForecast v) => v.precipitationChance;
  static const Field<DayPartForecast, num> _f$precipitationChance =
      Field('precipitationChance', _$precipitationChance);
  static String _$precipitationType(DayPartForecast v) => v.precipitationType;
  static const Field<DayPartForecast, String> _f$precipitationType =
      Field('precipitationType', _$precipitationType);
  static num _$snowfallAmount(DayPartForecast v) => v.snowfallAmount;
  static const Field<DayPartForecast, num> _f$snowfallAmount =
      Field('snowfallAmount', _$snowfallAmount);
  static int? _$windDirection(DayPartForecast v) => v.windDirection;
  static const Field<DayPartForecast, int> _f$windDirection =
      Field('windDirection', _$windDirection);
  static num _$windSpeed(DayPartForecast v) => v.windSpeed;
  static const Field<DayPartForecast, num> _f$windSpeed =
      Field('windSpeed', _$windSpeed);

  @override
  final MappableFields<DayPartForecast> fields = const {
    #cloudCover: _f$cloudCover,
    #conditionCode: _f$conditionCode,
    #forecastEnd: _f$forecastEnd,
    #forecastStart: _f$forecastStart,
    #humidity: _f$humidity,
    #precipitationAmount: _f$precipitationAmount,
    #precipitationChance: _f$precipitationChance,
    #precipitationType: _f$precipitationType,
    #snowfallAmount: _f$snowfallAmount,
    #windDirection: _f$windDirection,
    #windSpeed: _f$windSpeed,
  };

  static DayPartForecast _instantiate(DecodingData data) {
    return DayPartForecast(
        cloudCover: data.dec(_f$cloudCover),
        conditionCode: data.dec(_f$conditionCode),
        forecastEnd: data.dec(_f$forecastEnd),
        forecastStart: data.dec(_f$forecastStart),
        humidity: data.dec(_f$humidity),
        precipitationAmount: data.dec(_f$precipitationAmount),
        precipitationChance: data.dec(_f$precipitationChance),
        precipitationType: data.dec(_f$precipitationType),
        snowfallAmount: data.dec(_f$snowfallAmount),
        windDirection: data.dec(_f$windDirection),
        windSpeed: data.dec(_f$windSpeed));
  }

  @override
  final Function instantiate = _instantiate;

  static DayPartForecast fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DayPartForecast>(map);
  }

  static DayPartForecast fromJson(String json) {
    return ensureInitialized().decodeJson<DayPartForecast>(json);
  }
}

mixin DayPartForecastMappable {
  String toJson() {
    return DayPartForecastMapper.ensureInitialized()
        .encodeJson<DayPartForecast>(this as DayPartForecast);
  }

  Map<String, dynamic> toMap() {
    return DayPartForecastMapper.ensureInitialized()
        .encodeMap<DayPartForecast>(this as DayPartForecast);
  }

  DayPartForecastCopyWith<DayPartForecast, DayPartForecast, DayPartForecast>
      get copyWith => _DayPartForecastCopyWithImpl(
          this as DayPartForecast, $identity, $identity);
  @override
  String toString() {
    return DayPartForecastMapper.ensureInitialized()
        .stringifyValue(this as DayPartForecast);
  }

  @override
  bool operator ==(Object other) {
    return DayPartForecastMapper.ensureInitialized()
        .equalsValue(this as DayPartForecast, other);
  }

  @override
  int get hashCode {
    return DayPartForecastMapper.ensureInitialized()
        .hashValue(this as DayPartForecast);
  }
}

extension DayPartForecastValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DayPartForecast, $Out> {
  DayPartForecastCopyWith<$R, DayPartForecast, $Out> get $asDayPartForecast =>
      $base.as((v, t, t2) => _DayPartForecastCopyWithImpl(v, t, t2));
}

abstract class DayPartForecastCopyWith<$R, $In extends DayPartForecast, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {num? cloudCover,
      String? conditionCode,
      DateTime? forecastEnd,
      DateTime? forecastStart,
      num? humidity,
      num? precipitationAmount,
      num? precipitationChance,
      String? precipitationType,
      num? snowfallAmount,
      int? windDirection,
      num? windSpeed});
  DayPartForecastCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DayPartForecastCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DayPartForecast, $Out>
    implements DayPartForecastCopyWith<$R, DayPartForecast, $Out> {
  _DayPartForecastCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DayPartForecast> $mapper =
      DayPartForecastMapper.ensureInitialized();
  @override
  $R call(
          {Object? cloudCover = $none,
          String? conditionCode,
          Object? forecastEnd = $none,
          DateTime? forecastStart,
          num? humidity,
          num? precipitationAmount,
          num? precipitationChance,
          String? precipitationType,
          num? snowfallAmount,
          Object? windDirection = $none,
          num? windSpeed}) =>
      $apply(FieldCopyWithData({
        if (cloudCover != $none) #cloudCover: cloudCover,
        if (conditionCode != null) #conditionCode: conditionCode,
        if (forecastEnd != $none) #forecastEnd: forecastEnd,
        if (forecastStart != null) #forecastStart: forecastStart,
        if (humidity != null) #humidity: humidity,
        if (precipitationAmount != null)
          #precipitationAmount: precipitationAmount,
        if (precipitationChance != null)
          #precipitationChance: precipitationChance,
        if (precipitationType != null) #precipitationType: precipitationType,
        if (snowfallAmount != null) #snowfallAmount: snowfallAmount,
        if (windDirection != $none) #windDirection: windDirection,
        if (windSpeed != null) #windSpeed: windSpeed
      }));
  @override
  DayPartForecast $make(CopyWithData data) => DayPartForecast(
      cloudCover: data.get(#cloudCover, or: $value.cloudCover),
      conditionCode: data.get(#conditionCode, or: $value.conditionCode),
      forecastEnd: data.get(#forecastEnd, or: $value.forecastEnd),
      forecastStart: data.get(#forecastStart, or: $value.forecastStart),
      humidity: data.get(#humidity, or: $value.humidity),
      precipitationAmount:
          data.get(#precipitationAmount, or: $value.precipitationAmount),
      precipitationChance:
          data.get(#precipitationChance, or: $value.precipitationChance),
      precipitationType:
          data.get(#precipitationType, or: $value.precipitationType),
      snowfallAmount: data.get(#snowfallAmount, or: $value.snowfallAmount),
      windDirection: data.get(#windDirection, or: $value.windDirection),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed));

  @override
  DayPartForecastCopyWith<$R2, DayPartForecast, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DayPartForecastCopyWithImpl($value, $cast, t);
}
