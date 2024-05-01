// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'forecast_minute.dart';

class ForecastMinuteMapper extends ClassMapperBase<ForecastMinute> {
  ForecastMinuteMapper._();

  static ForecastMinuteMapper? _instance;
  static ForecastMinuteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ForecastMinuteMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ForecastMinute';

  static num _$precipitationChance(ForecastMinute v) => v.precipitationChance;
  static const Field<ForecastMinute, num> _f$precipitationChance =
      Field('precipitationChance', _$precipitationChance);
  static num _$precipitationIntensity(ForecastMinute v) =>
      v.precipitationIntensity;
  static const Field<ForecastMinute, num> _f$precipitationIntensity =
      Field('precipitationIntensity', _$precipitationIntensity);
  static DateTime _$startTime(ForecastMinute v) => v.startTime;
  static const Field<ForecastMinute, DateTime> _f$startTime =
      Field('startTime', _$startTime);

  @override
  final MappableFields<ForecastMinute> fields = const {
    #precipitationChance: _f$precipitationChance,
    #precipitationIntensity: _f$precipitationIntensity,
    #startTime: _f$startTime,
  };

  static ForecastMinute _instantiate(DecodingData data) {
    return ForecastMinute(
        precipitationChance: data.dec(_f$precipitationChance),
        precipitationIntensity: data.dec(_f$precipitationIntensity),
        startTime: data.dec(_f$startTime));
  }

  @override
  final Function instantiate = _instantiate;

  static ForecastMinute fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ForecastMinute>(map);
  }

  static ForecastMinute fromJson(String json) {
    return ensureInitialized().decodeJson<ForecastMinute>(json);
  }
}

mixin ForecastMinuteMappable {
  String toJson() {
    return ForecastMinuteMapper.ensureInitialized()
        .encodeJson<ForecastMinute>(this as ForecastMinute);
  }

  Map<String, dynamic> toMap() {
    return ForecastMinuteMapper.ensureInitialized()
        .encodeMap<ForecastMinute>(this as ForecastMinute);
  }

  ForecastMinuteCopyWith<ForecastMinute, ForecastMinute, ForecastMinute>
      get copyWith => _ForecastMinuteCopyWithImpl(
          this as ForecastMinute, $identity, $identity);
  @override
  String toString() {
    return ForecastMinuteMapper.ensureInitialized()
        .stringifyValue(this as ForecastMinute);
  }

  @override
  bool operator ==(Object other) {
    return ForecastMinuteMapper.ensureInitialized()
        .equalsValue(this as ForecastMinute, other);
  }

  @override
  int get hashCode {
    return ForecastMinuteMapper.ensureInitialized()
        .hashValue(this as ForecastMinute);
  }
}

extension ForecastMinuteValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ForecastMinute, $Out> {
  ForecastMinuteCopyWith<$R, ForecastMinute, $Out> get $asForecastMinute =>
      $base.as((v, t, t2) => _ForecastMinuteCopyWithImpl(v, t, t2));
}

abstract class ForecastMinuteCopyWith<$R, $In extends ForecastMinute, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {num? precipitationChance,
      num? precipitationIntensity,
      DateTime? startTime});
  ForecastMinuteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ForecastMinuteCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ForecastMinute, $Out>
    implements ForecastMinuteCopyWith<$R, ForecastMinute, $Out> {
  _ForecastMinuteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ForecastMinute> $mapper =
      ForecastMinuteMapper.ensureInitialized();
  @override
  $R call(
          {num? precipitationChance,
          num? precipitationIntensity,
          DateTime? startTime}) =>
      $apply(FieldCopyWithData({
        if (precipitationChance != null)
          #precipitationChance: precipitationChance,
        if (precipitationIntensity != null)
          #precipitationIntensity: precipitationIntensity,
        if (startTime != null) #startTime: startTime
      }));
  @override
  ForecastMinute $make(CopyWithData data) => ForecastMinute(
      precipitationChance:
          data.get(#precipitationChance, or: $value.precipitationChance),
      precipitationIntensity:
          data.get(#precipitationIntensity, or: $value.precipitationIntensity),
      startTime: data.get(#startTime, or: $value.startTime));

  @override
  ForecastMinuteCopyWith<$R2, ForecastMinute, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ForecastMinuteCopyWithImpl($value, $cast, t);
}
