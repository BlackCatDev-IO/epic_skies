// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'unit_settings_model.dart';

class UnitSettingsMapper extends ClassMapperBase<UnitSettings> {
  UnitSettingsMapper._();

  static UnitSettingsMapper? _instance;
  static UnitSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UnitSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UnitSettings';

  static bool _$tempUnitsMetric(UnitSettings v) => v.tempUnitsMetric;
  static const Field<UnitSettings, bool> _f$tempUnitsMetric =
      Field('tempUnitsMetric', _$tempUnitsMetric, opt: true, def: false);
  static bool _$timeIn24Hrs(UnitSettings v) => v.timeIn24Hrs;
  static const Field<UnitSettings, bool> _f$timeIn24Hrs =
      Field('timeIn24Hrs', _$timeIn24Hrs, opt: true, def: false);
  static bool _$precipInMm(UnitSettings v) => v.precipInMm;
  static const Field<UnitSettings, bool> _f$precipInMm =
      Field('precipInMm', _$precipInMm, opt: true, def: false);
  static bool _$speedInKph(UnitSettings v) => v.speedInKph;
  static const Field<UnitSettings, bool> _f$speedInKph =
      Field('speedInKph', _$speedInKph, opt: true, def: false);

  @override
  final MappableFields<UnitSettings> fields = const {
    #tempUnitsMetric: _f$tempUnitsMetric,
    #timeIn24Hrs: _f$timeIn24Hrs,
    #precipInMm: _f$precipInMm,
    #speedInKph: _f$speedInKph,
  };

  static UnitSettings _instantiate(DecodingData data) {
    return UnitSettings(
        tempUnitsMetric: data.dec(_f$tempUnitsMetric),
        timeIn24Hrs: data.dec(_f$timeIn24Hrs),
        precipInMm: data.dec(_f$precipInMm),
        speedInKph: data.dec(_f$speedInKph));
  }

  @override
  final Function instantiate = _instantiate;

  static UnitSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UnitSettings>(map);
  }

  static UnitSettings fromJson(String json) {
    return ensureInitialized().decodeJson<UnitSettings>(json);
  }
}

mixin UnitSettingsMappable {
  String toJson() {
    return UnitSettingsMapper.ensureInitialized()
        .encodeJson<UnitSettings>(this as UnitSettings);
  }

  Map<String, dynamic> toMap() {
    return UnitSettingsMapper.ensureInitialized()
        .encodeMap<UnitSettings>(this as UnitSettings);
  }

  UnitSettingsCopyWith<UnitSettings, UnitSettings, UnitSettings> get copyWith =>
      _UnitSettingsCopyWithImpl(this as UnitSettings, $identity, $identity);
  @override
  String toString() {
    return UnitSettingsMapper.ensureInitialized()
        .stringifyValue(this as UnitSettings);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UnitSettingsMapper.ensureInitialized()
                .isValueEqual(this as UnitSettings, other));
  }

  @override
  int get hashCode {
    return UnitSettingsMapper.ensureInitialized()
        .hashValue(this as UnitSettings);
  }
}

extension UnitSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UnitSettings, $Out> {
  UnitSettingsCopyWith<$R, UnitSettings, $Out> get $asUnitSettings =>
      $base.as((v, t, t2) => _UnitSettingsCopyWithImpl(v, t, t2));
}

abstract class UnitSettingsCopyWith<$R, $In extends UnitSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? tempUnitsMetric,
      bool? timeIn24Hrs,
      bool? precipInMm,
      bool? speedInKph});
  UnitSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UnitSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UnitSettings, $Out>
    implements UnitSettingsCopyWith<$R, UnitSettings, $Out> {
  _UnitSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UnitSettings> $mapper =
      UnitSettingsMapper.ensureInitialized();
  @override
  $R call(
          {bool? tempUnitsMetric,
          bool? timeIn24Hrs,
          bool? precipInMm,
          bool? speedInKph}) =>
      $apply(FieldCopyWithData({
        if (tempUnitsMetric != null) #tempUnitsMetric: tempUnitsMetric,
        if (timeIn24Hrs != null) #timeIn24Hrs: timeIn24Hrs,
        if (precipInMm != null) #precipInMm: precipInMm,
        if (speedInKph != null) #speedInKph: speedInKph
      }));
  @override
  UnitSettings $make(CopyWithData data) => UnitSettings(
      tempUnitsMetric: data.get(#tempUnitsMetric, or: $value.tempUnitsMetric),
      timeIn24Hrs: data.get(#timeIn24Hrs, or: $value.timeIn24Hrs),
      precipInMm: data.get(#precipInMm, or: $value.precipInMm),
      speedInKph: data.get(#speedInKph, or: $value.speedInKph));

  @override
  UnitSettingsCopyWith<$R2, UnitSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UnitSettingsCopyWithImpl($value, $cast, t);
}
