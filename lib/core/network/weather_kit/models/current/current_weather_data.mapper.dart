// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'current_weather_data.dart';

class CurrentWeatherDataMapper extends ClassMapperBase<CurrentWeatherData> {
  CurrentWeatherDataMapper._();

  static CurrentWeatherDataMapper? _instance;
  static CurrentWeatherDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrentWeatherDataMapper._());
      MetaDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CurrentWeatherData';

  static MetaData _$metadata(CurrentWeatherData v) => v.metadata;
  static const Field<CurrentWeatherData, MetaData> _f$metadata =
      Field('metadata', _$metadata);
  static DateTime _$asOf(CurrentWeatherData v) => v.asOf;
  static const Field<CurrentWeatherData, DateTime> _f$asOf =
      Field('asOf', _$asOf);
  static double? _$cloudCover(CurrentWeatherData v) => v.cloudCover;
  static const Field<CurrentWeatherData, double> _f$cloudCover =
      Field('cloudCover', _$cloudCover);
  static String _$conditionCode(CurrentWeatherData v) => v.conditionCode;
  static const Field<CurrentWeatherData, String> _f$conditionCode =
      Field('conditionCode', _$conditionCode);
  static bool? _$daylight(CurrentWeatherData v) => v.daylight;
  static const Field<CurrentWeatherData, bool> _f$daylight =
      Field('daylight', _$daylight);
  static double _$humidity(CurrentWeatherData v) => v.humidity;
  static const Field<CurrentWeatherData, double> _f$humidity =
      Field('humidity', _$humidity);
  static double _$precipitationIntensity(CurrentWeatherData v) =>
      v.precipitationIntensity;
  static const Field<CurrentWeatherData, double> _f$precipitationIntensity =
      Field('precipitationIntensity', _$precipitationIntensity);
  static double _$pressure(CurrentWeatherData v) => v.pressure;
  static const Field<CurrentWeatherData, double> _f$pressure =
      Field('pressure', _$pressure);
  static String _$pressureTrend(CurrentWeatherData v) => v.pressureTrend;
  static const Field<CurrentWeatherData, String> _f$pressureTrend =
      Field('pressureTrend', _$pressureTrend);
  static double _$temperature(CurrentWeatherData v) => v.temperature;
  static const Field<CurrentWeatherData, double> _f$temperature =
      Field('temperature', _$temperature);
  static double _$temperatureApparent(CurrentWeatherData v) =>
      v.temperatureApparent;
  static const Field<CurrentWeatherData, double> _f$temperatureApparent =
      Field('temperatureApparent', _$temperatureApparent);
  static double _$temperatureDewPoint(CurrentWeatherData v) =>
      v.temperatureDewPoint;
  static const Field<CurrentWeatherData, double> _f$temperatureDewPoint =
      Field('temperatureDewPoint', _$temperatureDewPoint);
  static int _$uvIndex(CurrentWeatherData v) => v.uvIndex;
  static const Field<CurrentWeatherData, int> _f$uvIndex =
      Field('uvIndex', _$uvIndex);
  static double _$visibility(CurrentWeatherData v) => v.visibility;
  static const Field<CurrentWeatherData, double> _f$visibility =
      Field('visibility', _$visibility);
  static int? _$windDirection(CurrentWeatherData v) => v.windDirection;
  static const Field<CurrentWeatherData, int> _f$windDirection =
      Field('windDirection', _$windDirection);
  static double? _$windGust(CurrentWeatherData v) => v.windGust;
  static const Field<CurrentWeatherData, double> _f$windGust =
      Field('windGust', _$windGust);
  static double _$windSpeed(CurrentWeatherData v) => v.windSpeed;
  static const Field<CurrentWeatherData, double> _f$windSpeed =
      Field('windSpeed', _$windSpeed);

  @override
  final MappableFields<CurrentWeatherData> fields = const {
    #metadata: _f$metadata,
    #asOf: _f$asOf,
    #cloudCover: _f$cloudCover,
    #conditionCode: _f$conditionCode,
    #daylight: _f$daylight,
    #humidity: _f$humidity,
    #precipitationIntensity: _f$precipitationIntensity,
    #pressure: _f$pressure,
    #pressureTrend: _f$pressureTrend,
    #temperature: _f$temperature,
    #temperatureApparent: _f$temperatureApparent,
    #temperatureDewPoint: _f$temperatureDewPoint,
    #uvIndex: _f$uvIndex,
    #visibility: _f$visibility,
    #windDirection: _f$windDirection,
    #windGust: _f$windGust,
    #windSpeed: _f$windSpeed,
  };

  static CurrentWeatherData _instantiate(DecodingData data) {
    return CurrentWeatherData(
        metadata: data.dec(_f$metadata),
        asOf: data.dec(_f$asOf),
        cloudCover: data.dec(_f$cloudCover),
        conditionCode: data.dec(_f$conditionCode),
        daylight: data.dec(_f$daylight),
        humidity: data.dec(_f$humidity),
        precipitationIntensity: data.dec(_f$precipitationIntensity),
        pressure: data.dec(_f$pressure),
        pressureTrend: data.dec(_f$pressureTrend),
        temperature: data.dec(_f$temperature),
        temperatureApparent: data.dec(_f$temperatureApparent),
        temperatureDewPoint: data.dec(_f$temperatureDewPoint),
        uvIndex: data.dec(_f$uvIndex),
        visibility: data.dec(_f$visibility),
        windDirection: data.dec(_f$windDirection),
        windGust: data.dec(_f$windGust),
        windSpeed: data.dec(_f$windSpeed));
  }

  @override
  final Function instantiate = _instantiate;

  static CurrentWeatherData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CurrentWeatherData>(map);
  }

  static CurrentWeatherData fromJson(String json) {
    return ensureInitialized().decodeJson<CurrentWeatherData>(json);
  }
}

mixin CurrentWeatherDataMappable {
  String toJson() {
    return CurrentWeatherDataMapper.ensureInitialized()
        .encodeJson<CurrentWeatherData>(this as CurrentWeatherData);
  }

  Map<String, dynamic> toMap() {
    return CurrentWeatherDataMapper.ensureInitialized()
        .encodeMap<CurrentWeatherData>(this as CurrentWeatherData);
  }

  CurrentWeatherDataCopyWith<CurrentWeatherData, CurrentWeatherData,
          CurrentWeatherData>
      get copyWith => _CurrentWeatherDataCopyWithImpl(
          this as CurrentWeatherData, $identity, $identity);
  @override
  String toString() {
    return CurrentWeatherDataMapper.ensureInitialized()
        .stringifyValue(this as CurrentWeatherData);
  }

  @override
  bool operator ==(Object other) {
    return CurrentWeatherDataMapper.ensureInitialized()
        .equalsValue(this as CurrentWeatherData, other);
  }

  @override
  int get hashCode {
    return CurrentWeatherDataMapper.ensureInitialized()
        .hashValue(this as CurrentWeatherData);
  }
}

extension CurrentWeatherDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrentWeatherData, $Out> {
  CurrentWeatherDataCopyWith<$R, CurrentWeatherData, $Out>
      get $asCurrentWeatherData =>
          $base.as((v, t, t2) => _CurrentWeatherDataCopyWithImpl(v, t, t2));
}

abstract class CurrentWeatherDataCopyWith<$R, $In extends CurrentWeatherData,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  MetaDataCopyWith<$R, MetaData, MetaData> get metadata;
  $R call(
      {MetaData? metadata,
      DateTime? asOf,
      double? cloudCover,
      String? conditionCode,
      bool? daylight,
      double? humidity,
      double? precipitationIntensity,
      double? pressure,
      String? pressureTrend,
      double? temperature,
      double? temperatureApparent,
      double? temperatureDewPoint,
      int? uvIndex,
      double? visibility,
      int? windDirection,
      double? windGust,
      double? windSpeed});
  CurrentWeatherDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CurrentWeatherDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrentWeatherData, $Out>
    implements CurrentWeatherDataCopyWith<$R, CurrentWeatherData, $Out> {
  _CurrentWeatherDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrentWeatherData> $mapper =
      CurrentWeatherDataMapper.ensureInitialized();
  @override
  MetaDataCopyWith<$R, MetaData, MetaData> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  $R call(
          {MetaData? metadata,
          DateTime? asOf,
          Object? cloudCover = $none,
          String? conditionCode,
          Object? daylight = $none,
          double? humidity,
          double? precipitationIntensity,
          double? pressure,
          String? pressureTrend,
          double? temperature,
          double? temperatureApparent,
          double? temperatureDewPoint,
          int? uvIndex,
          double? visibility,
          Object? windDirection = $none,
          Object? windGust = $none,
          double? windSpeed}) =>
      $apply(FieldCopyWithData({
        if (metadata != null) #metadata: metadata,
        if (asOf != null) #asOf: asOf,
        if (cloudCover != $none) #cloudCover: cloudCover,
        if (conditionCode != null) #conditionCode: conditionCode,
        if (daylight != $none) #daylight: daylight,
        if (humidity != null) #humidity: humidity,
        if (precipitationIntensity != null)
          #precipitationIntensity: precipitationIntensity,
        if (pressure != null) #pressure: pressure,
        if (pressureTrend != null) #pressureTrend: pressureTrend,
        if (temperature != null) #temperature: temperature,
        if (temperatureApparent != null)
          #temperatureApparent: temperatureApparent,
        if (temperatureDewPoint != null)
          #temperatureDewPoint: temperatureDewPoint,
        if (uvIndex != null) #uvIndex: uvIndex,
        if (visibility != null) #visibility: visibility,
        if (windDirection != $none) #windDirection: windDirection,
        if (windGust != $none) #windGust: windGust,
        if (windSpeed != null) #windSpeed: windSpeed
      }));
  @override
  CurrentWeatherData $make(CopyWithData data) => CurrentWeatherData(
      metadata: data.get(#metadata, or: $value.metadata),
      asOf: data.get(#asOf, or: $value.asOf),
      cloudCover: data.get(#cloudCover, or: $value.cloudCover),
      conditionCode: data.get(#conditionCode, or: $value.conditionCode),
      daylight: data.get(#daylight, or: $value.daylight),
      humidity: data.get(#humidity, or: $value.humidity),
      precipitationIntensity:
          data.get(#precipitationIntensity, or: $value.precipitationIntensity),
      pressure: data.get(#pressure, or: $value.pressure),
      pressureTrend: data.get(#pressureTrend, or: $value.pressureTrend),
      temperature: data.get(#temperature, or: $value.temperature),
      temperatureApparent:
          data.get(#temperatureApparent, or: $value.temperatureApparent),
      temperatureDewPoint:
          data.get(#temperatureDewPoint, or: $value.temperatureDewPoint),
      uvIndex: data.get(#uvIndex, or: $value.uvIndex),
      visibility: data.get(#visibility, or: $value.visibility),
      windDirection: data.get(#windDirection, or: $value.windDirection),
      windGust: data.get(#windGust, or: $value.windGust),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed));

  @override
  CurrentWeatherDataCopyWith<$R2, CurrentWeatherData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CurrentWeatherDataCopyWithImpl($value, $cast, t);
}
