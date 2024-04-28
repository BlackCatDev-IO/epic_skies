// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'forecast_hourly.dart';

class ForecastHourlyMapper extends ClassMapperBase<ForecastHourly> {
  ForecastHourlyMapper._();

  static ForecastHourlyMapper? _instance;
  static ForecastHourlyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ForecastHourlyMapper._());
      meta.MetaDataMapper.ensureInitialized();
      HourWeatherConditionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ForecastHourly';

  static meta.MetaData _$metadata(ForecastHourly v) => v.metadata;
  static const Field<ForecastHourly, meta.MetaData> _f$metadata =
      Field('metadata', _$metadata);
  static List<HourWeatherConditions> _$hours(ForecastHourly v) => v.hours;
  static const Field<ForecastHourly, List<HourWeatherConditions>> _f$hours =
      Field('hours', _$hours);

  @override
  final MappableFields<ForecastHourly> fields = const {
    #metadata: _f$metadata,
    #hours: _f$hours,
  };

  static ForecastHourly _instantiate(DecodingData data) {
    return ForecastHourly(
        metadata: data.dec(_f$metadata), hours: data.dec(_f$hours));
  }

  @override
  final Function instantiate = _instantiate;

  static ForecastHourly fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ForecastHourly>(map);
  }

  static ForecastHourly fromJson(String json) {
    return ensureInitialized().decodeJson<ForecastHourly>(json);
  }
}

mixin ForecastHourlyMappable {
  String toJson() {
    return ForecastHourlyMapper.ensureInitialized()
        .encodeJson<ForecastHourly>(this as ForecastHourly);
  }

  Map<String, dynamic> toMap() {
    return ForecastHourlyMapper.ensureInitialized()
        .encodeMap<ForecastHourly>(this as ForecastHourly);
  }

  ForecastHourlyCopyWith<ForecastHourly, ForecastHourly, ForecastHourly>
      get copyWith => _ForecastHourlyCopyWithImpl(
          this as ForecastHourly, $identity, $identity);
  @override
  String toString() {
    return ForecastHourlyMapper.ensureInitialized()
        .stringifyValue(this as ForecastHourly);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ForecastHourlyMapper.ensureInitialized()
                .isValueEqual(this as ForecastHourly, other));
  }

  @override
  int get hashCode {
    return ForecastHourlyMapper.ensureInitialized()
        .hashValue(this as ForecastHourly);
  }
}

extension ForecastHourlyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ForecastHourly, $Out> {
  ForecastHourlyCopyWith<$R, ForecastHourly, $Out> get $asForecastHourly =>
      $base.as((v, t, t2) => _ForecastHourlyCopyWithImpl(v, t, t2));
}

abstract class ForecastHourlyCopyWith<$R, $In extends ForecastHourly, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  meta.MetaDataCopyWith<$R, meta.MetaData, meta.MetaData> get metadata;
  ListCopyWith<
      $R,
      HourWeatherConditions,
      HourWeatherConditionsCopyWith<$R, HourWeatherConditions,
          HourWeatherConditions>> get hours;
  $R call({meta.MetaData? metadata, List<HourWeatherConditions>? hours});
  ForecastHourlyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ForecastHourlyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ForecastHourly, $Out>
    implements ForecastHourlyCopyWith<$R, ForecastHourly, $Out> {
  _ForecastHourlyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ForecastHourly> $mapper =
      ForecastHourlyMapper.ensureInitialized();
  @override
  meta.MetaDataCopyWith<$R, meta.MetaData, meta.MetaData> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  ListCopyWith<
      $R,
      HourWeatherConditions,
      HourWeatherConditionsCopyWith<$R, HourWeatherConditions,
          HourWeatherConditions>> get hours => ListCopyWith(
      $value.hours, (v, t) => v.copyWith.$chain(t), (v) => call(hours: v));
  @override
  $R call({meta.MetaData? metadata, List<HourWeatherConditions>? hours}) =>
      $apply(FieldCopyWithData({
        if (metadata != null) #metadata: metadata,
        if (hours != null) #hours: hours
      }));
  @override
  ForecastHourly $make(CopyWithData data) => ForecastHourly(
      metadata: data.get(#metadata, or: $value.metadata),
      hours: data.get(#hours, or: $value.hours));

  @override
  ForecastHourlyCopyWith<$R2, ForecastHourly, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ForecastHourlyCopyWithImpl($value, $cast, t);
}
