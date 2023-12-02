// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'forecast_daily.dart';

class ForecastDailyMapper extends ClassMapperBase<ForecastDaily> {
  ForecastDailyMapper._();

  static ForecastDailyMapper? _instance;
  static ForecastDailyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ForecastDailyMapper._());
      MetaDataMapper.ensureInitialized();
      DayWeatherConditionsMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'ForecastDaily';

  static MetaData _$metadata(ForecastDaily v) => v.metadata;
  static const Field<ForecastDaily, MetaData> _f$metadata =
      Field('metadata', _$metadata);
  static List<DayWeatherConditions> _$days(ForecastDaily v) => v.days;
  static const Field<ForecastDaily, List<DayWeatherConditions>> _f$days =
      Field('days', _$days);

  @override
  final Map<Symbol, Field<ForecastDaily, dynamic>> fields = const {
    #metadata: _f$metadata,
    #days: _f$days,
  };

  static ForecastDaily _instantiate(DecodingData data) {
    return ForecastDaily(
        metadata: data.dec(_f$metadata), days: data.dec(_f$days));
  }

  @override
  final Function instantiate = _instantiate;

  static ForecastDaily fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<ForecastDaily>(map));
  }

  static ForecastDaily fromJson(String json) {
    return _guard((c) => c.fromJson<ForecastDaily>(json));
  }
}

mixin ForecastDailyMappable {
  String toJson() {
    return ForecastDailyMapper._guard((c) => c.toJson(this as ForecastDaily));
  }

  Map<String, dynamic> toMap() {
    return ForecastDailyMapper._guard((c) => c.toMap(this as ForecastDaily));
  }

  ForecastDailyCopyWith<ForecastDaily, ForecastDaily, ForecastDaily>
      get copyWith => _ForecastDailyCopyWithImpl(
          this as ForecastDaily, $identity, $identity);
  @override
  String toString() {
    return ForecastDailyMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ForecastDailyMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return ForecastDailyMapper._guard((c) => c.hash(this));
  }
}

extension ForecastDailyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ForecastDaily, $Out> {
  ForecastDailyCopyWith<$R, ForecastDaily, $Out> get $asForecastDaily =>
      $base.as((v, t, t2) => _ForecastDailyCopyWithImpl(v, t, t2));
}

abstract class ForecastDailyCopyWith<$R, $In extends ForecastDaily, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MetaDataCopyWith<$R, MetaData, MetaData> get metadata;
  ListCopyWith<
      $R,
      DayWeatherConditions,
      DayWeatherConditionsCopyWith<$R, DayWeatherConditions,
          DayWeatherConditions>> get days;
  $R call({MetaData? metadata, List<DayWeatherConditions>? days});
  ForecastDailyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ForecastDailyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ForecastDaily, $Out>
    implements ForecastDailyCopyWith<$R, ForecastDaily, $Out> {
  _ForecastDailyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ForecastDaily> $mapper =
      ForecastDailyMapper.ensureInitialized();
  @override
  MetaDataCopyWith<$R, MetaData, MetaData> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  ListCopyWith<
      $R,
      DayWeatherConditions,
      DayWeatherConditionsCopyWith<$R, DayWeatherConditions,
          DayWeatherConditions>> get days => ListCopyWith(
      $value.days, (v, t) => v.copyWith.$chain(t), (v) => call(days: v));
  @override
  $R call({MetaData? metadata, List<DayWeatherConditions>? days}) =>
      $apply(FieldCopyWithData({
        if (metadata != null) #metadata: metadata,
        if (days != null) #days: days
      }));
  @override
  ForecastDaily $make(CopyWithData data) => ForecastDaily(
      metadata: data.get(#metadata, or: $value.metadata),
      days: data.get(#days, or: $value.days));

  @override
  ForecastDailyCopyWith<$R2, ForecastDaily, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ForecastDailyCopyWithImpl($value, $cast, t);
}
