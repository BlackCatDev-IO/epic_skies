// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'forecast_period_summary.dart';

class ForecastPeriodSummaryMapper
    extends ClassMapperBase<ForecastPeriodSummary> {
  ForecastPeriodSummaryMapper._();

  static ForecastPeriodSummaryMapper? _instance;
  static ForecastPeriodSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ForecastPeriodSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ForecastPeriodSummary';

  static DateTime _$startTime(ForecastPeriodSummary v) => v.startTime;
  static const Field<ForecastPeriodSummary, DateTime> _f$startTime =
      Field('startTime', _$startTime);
  static DateTime? _$endTime(ForecastPeriodSummary v) => v.endTime;
  static const Field<ForecastPeriodSummary, DateTime> _f$endTime =
      Field('endTime', _$endTime);
  static String _$condition(ForecastPeriodSummary v) => v.condition;
  static const Field<ForecastPeriodSummary, String> _f$condition =
      Field('condition', _$condition);
  static double _$precipitationChance(ForecastPeriodSummary v) =>
      v.precipitationChance;
  static const Field<ForecastPeriodSummary, double> _f$precipitationChance =
      Field('precipitationChance', _$precipitationChance);
  static double _$precipitationIntensity(ForecastPeriodSummary v) =>
      v.precipitationIntensity;
  static const Field<ForecastPeriodSummary, double> _f$precipitationIntensity =
      Field('precipitationIntensity', _$precipitationIntensity);

  @override
  final MappableFields<ForecastPeriodSummary> fields = const {
    #startTime: _f$startTime,
    #endTime: _f$endTime,
    #condition: _f$condition,
    #precipitationChance: _f$precipitationChance,
    #precipitationIntensity: _f$precipitationIntensity,
  };

  static ForecastPeriodSummary _instantiate(DecodingData data) {
    return ForecastPeriodSummary(
        startTime: data.dec(_f$startTime),
        endTime: data.dec(_f$endTime),
        condition: data.dec(_f$condition),
        precipitationChance: data.dec(_f$precipitationChance),
        precipitationIntensity: data.dec(_f$precipitationIntensity));
  }

  @override
  final Function instantiate = _instantiate;

  static ForecastPeriodSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ForecastPeriodSummary>(map);
  }

  static ForecastPeriodSummary fromJson(String json) {
    return ensureInitialized().decodeJson<ForecastPeriodSummary>(json);
  }
}

mixin ForecastPeriodSummaryMappable {
  String toJson() {
    return ForecastPeriodSummaryMapper.ensureInitialized()
        .encodeJson<ForecastPeriodSummary>(this as ForecastPeriodSummary);
  }

  Map<String, dynamic> toMap() {
    return ForecastPeriodSummaryMapper.ensureInitialized()
        .encodeMap<ForecastPeriodSummary>(this as ForecastPeriodSummary);
  }

  ForecastPeriodSummaryCopyWith<ForecastPeriodSummary, ForecastPeriodSummary,
          ForecastPeriodSummary>
      get copyWith => _ForecastPeriodSummaryCopyWithImpl(
          this as ForecastPeriodSummary, $identity, $identity);
  @override
  String toString() {
    return ForecastPeriodSummaryMapper.ensureInitialized()
        .stringifyValue(this as ForecastPeriodSummary);
  }

  @override
  bool operator ==(Object other) {
    return ForecastPeriodSummaryMapper.ensureInitialized()
        .equalsValue(this as ForecastPeriodSummary, other);
  }

  @override
  int get hashCode {
    return ForecastPeriodSummaryMapper.ensureInitialized()
        .hashValue(this as ForecastPeriodSummary);
  }
}

extension ForecastPeriodSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ForecastPeriodSummary, $Out> {
  ForecastPeriodSummaryCopyWith<$R, ForecastPeriodSummary, $Out>
      get $asForecastPeriodSummary =>
          $base.as((v, t, t2) => _ForecastPeriodSummaryCopyWithImpl(v, t, t2));
}

abstract class ForecastPeriodSummaryCopyWith<
    $R,
    $In extends ForecastPeriodSummary,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {DateTime? startTime,
      DateTime? endTime,
      String? condition,
      double? precipitationChance,
      double? precipitationIntensity});
  ForecastPeriodSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ForecastPeriodSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ForecastPeriodSummary, $Out>
    implements ForecastPeriodSummaryCopyWith<$R, ForecastPeriodSummary, $Out> {
  _ForecastPeriodSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ForecastPeriodSummary> $mapper =
      ForecastPeriodSummaryMapper.ensureInitialized();
  @override
  $R call(
          {DateTime? startTime,
          Object? endTime = $none,
          String? condition,
          double? precipitationChance,
          double? precipitationIntensity}) =>
      $apply(FieldCopyWithData({
        if (startTime != null) #startTime: startTime,
        if (endTime != $none) #endTime: endTime,
        if (condition != null) #condition: condition,
        if (precipitationChance != null)
          #precipitationChance: precipitationChance,
        if (precipitationIntensity != null)
          #precipitationIntensity: precipitationIntensity
      }));
  @override
  ForecastPeriodSummary $make(CopyWithData data) => ForecastPeriodSummary(
      startTime: data.get(#startTime, or: $value.startTime),
      endTime: data.get(#endTime, or: $value.endTime),
      condition: data.get(#condition, or: $value.condition),
      precipitationChance:
          data.get(#precipitationChance, or: $value.precipitationChance),
      precipitationIntensity:
          data.get(#precipitationIntensity, or: $value.precipitationIntensity));

  @override
  ForecastPeriodSummaryCopyWith<$R2, ForecastPeriodSummary, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ForecastPeriodSummaryCopyWithImpl($value, $cast, t);
}
