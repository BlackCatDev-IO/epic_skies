// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reference_times_model.dart';

class ReferenceTimesModelMapper extends ClassMapperBase<ReferenceTimesModel> {
  ReferenceTimesModelMapper._();

  static ReferenceTimesModelMapper? _instance;
  static ReferenceTimesModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReferenceTimesModelMapper._());
      SunTimesModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ReferenceTimesModel';

  static DateTime? _$now(ReferenceTimesModel v) => v.now;
  static const Field<ReferenceTimesModel, DateTime> _f$now =
      Field('now', _$now, opt: true);
  static int _$timezoneOffsetInMs(ReferenceTimesModel v) =>
      v.timezoneOffsetInMs;
  static const Field<ReferenceTimesModel, int> _f$timezoneOffsetInMs =
      Field('timezoneOffsetInMs', _$timezoneOffsetInMs, opt: true, def: 0);
  static String _$timezone(ReferenceTimesModel v) => v.timezone;
  static const Field<ReferenceTimesModel, String> _f$timezone =
      Field('timezone', _$timezone, opt: true, def: '');
  static List<SunTimesModel> _$refererenceSuntimes(ReferenceTimesModel v) =>
      v.refererenceSuntimes;
  static const Field<ReferenceTimesModel, List<SunTimesModel>>
      _f$refererenceSuntimes = Field(
          'refererenceSuntimes', _$refererenceSuntimes,
          opt: true, def: const []);
  static bool _$isDay(ReferenceTimesModel v) => v.isDay;
  static const Field<ReferenceTimesModel, bool> _f$isDay =
      Field('isDay', _$isDay, opt: true, def: true);

  @override
  final MappableFields<ReferenceTimesModel> fields = const {
    #now: _f$now,
    #timezoneOffsetInMs: _f$timezoneOffsetInMs,
    #timezone: _f$timezone,
    #refererenceSuntimes: _f$refererenceSuntimes,
    #isDay: _f$isDay,
  };

  static ReferenceTimesModel _instantiate(DecodingData data) {
    return ReferenceTimesModel(
        now: data.dec(_f$now),
        timezoneOffsetInMs: data.dec(_f$timezoneOffsetInMs),
        timezone: data.dec(_f$timezone),
        refererenceSuntimes: data.dec(_f$refererenceSuntimes),
        isDay: data.dec(_f$isDay));
  }

  @override
  final Function instantiate = _instantiate;

  static ReferenceTimesModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReferenceTimesModel>(map);
  }

  static ReferenceTimesModel fromJson(String json) {
    return ensureInitialized().decodeJson<ReferenceTimesModel>(json);
  }
}

mixin ReferenceTimesModelMappable {
  String toJson() {
    return ReferenceTimesModelMapper.ensureInitialized()
        .encodeJson<ReferenceTimesModel>(this as ReferenceTimesModel);
  }

  Map<String, dynamic> toMap() {
    return ReferenceTimesModelMapper.ensureInitialized()
        .encodeMap<ReferenceTimesModel>(this as ReferenceTimesModel);
  }

  ReferenceTimesModelCopyWith<ReferenceTimesModel, ReferenceTimesModel,
          ReferenceTimesModel>
      get copyWith => _ReferenceTimesModelCopyWithImpl(
          this as ReferenceTimesModel, $identity, $identity);
  @override
  String toString() {
    return ReferenceTimesModelMapper.ensureInitialized()
        .stringifyValue(this as ReferenceTimesModel);
  }

  @override
  bool operator ==(Object other) {
    return ReferenceTimesModelMapper.ensureInitialized()
        .equalsValue(this as ReferenceTimesModel, other);
  }

  @override
  int get hashCode {
    return ReferenceTimesModelMapper.ensureInitialized()
        .hashValue(this as ReferenceTimesModel);
  }
}

extension ReferenceTimesModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReferenceTimesModel, $Out> {
  ReferenceTimesModelCopyWith<$R, ReferenceTimesModel, $Out>
      get $asReferenceTimesModel =>
          $base.as((v, t, t2) => _ReferenceTimesModelCopyWithImpl(v, t, t2));
}

abstract class ReferenceTimesModelCopyWith<$R, $In extends ReferenceTimesModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SunTimesModel,
          SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel>>
      get refererenceSuntimes;
  $R call(
      {DateTime? now,
      int? timezoneOffsetInMs,
      String? timezone,
      List<SunTimesModel>? refererenceSuntimes,
      bool? isDay});
  ReferenceTimesModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ReferenceTimesModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReferenceTimesModel, $Out>
    implements ReferenceTimesModelCopyWith<$R, ReferenceTimesModel, $Out> {
  _ReferenceTimesModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReferenceTimesModel> $mapper =
      ReferenceTimesModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SunTimesModel,
          SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel>>
      get refererenceSuntimes => ListCopyWith($value.refererenceSuntimes,
          (v, t) => v.copyWith.$chain(t), (v) => call(refererenceSuntimes: v));
  @override
  $R call(
          {Object? now = $none,
          int? timezoneOffsetInMs,
          String? timezone,
          List<SunTimesModel>? refererenceSuntimes,
          bool? isDay}) =>
      $apply(FieldCopyWithData({
        if (now != $none) #now: now,
        if (timezoneOffsetInMs != null) #timezoneOffsetInMs: timezoneOffsetInMs,
        if (timezone != null) #timezone: timezone,
        if (refererenceSuntimes != null)
          #refererenceSuntimes: refererenceSuntimes,
        if (isDay != null) #isDay: isDay
      }));
  @override
  ReferenceTimesModel $make(CopyWithData data) => ReferenceTimesModel(
      now: data.get(#now, or: $value.now),
      timezoneOffsetInMs:
          data.get(#timezoneOffsetInMs, or: $value.timezoneOffsetInMs),
      timezone: data.get(#timezone, or: $value.timezone),
      refererenceSuntimes:
          data.get(#refererenceSuntimes, or: $value.refererenceSuntimes),
      isDay: data.get(#isDay, or: $value.isDay));

  @override
  ReferenceTimesModelCopyWith<$R2, ReferenceTimesModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ReferenceTimesModelCopyWithImpl($value, $cast, t);
}
