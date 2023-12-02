// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

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

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
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
  final Map<Symbol, Field<ForecastMinute, dynamic>> fields = const {
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
    return _guard((c) => c.fromMap<ForecastMinute>(map));
  }

  static ForecastMinute fromJson(String json) {
    return _guard((c) => c.fromJson<ForecastMinute>(json));
  }
}

mixin ForecastMinuteMappable {
  String toJson() {
    return ForecastMinuteMapper._guard((c) => c.toJson(this as ForecastMinute));
  }

  Map<String, dynamic> toMap() {
    return ForecastMinuteMapper._guard((c) => c.toMap(this as ForecastMinute));
  }

  ForecastMinuteCopyWith<ForecastMinute, ForecastMinute, ForecastMinute>
      get copyWith => _ForecastMinuteCopyWithImpl(
          this as ForecastMinute, $identity, $identity);
  @override
  String toString() {
    return ForecastMinuteMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ForecastMinuteMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return ForecastMinuteMapper._guard((c) => c.hash(this));
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
