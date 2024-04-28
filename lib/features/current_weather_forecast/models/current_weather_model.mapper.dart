// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'current_weather_model.dart';

class CurrentWeatherModelMapper extends ClassMapperBase<CurrentWeatherModel> {
  CurrentWeatherModelMapper._();

  static CurrentWeatherModelMapper? _instance;
  static CurrentWeatherModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrentWeatherModelMapper._());
      UnitSettingsMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CurrentWeatherModel';

  static int _$temp(CurrentWeatherModel v) => v.temp;
  static const Field<CurrentWeatherModel, int> _f$temp = Field('temp', _$temp);
  static int _$feelsLike(CurrentWeatherModel v) => v.feelsLike;
  static const Field<CurrentWeatherModel, int> _f$feelsLike =
      Field('feelsLike', _$feelsLike);
  static int _$windSpeed(CurrentWeatherModel v) => v.windSpeed;
  static const Field<CurrentWeatherModel, int> _f$windSpeed =
      Field('windSpeed', _$windSpeed);
  static String _$condition(CurrentWeatherModel v) => v.condition;
  static const Field<CurrentWeatherModel, String> _f$condition =
      Field('condition', _$condition);
  static UnitSettings _$unitSettings(CurrentWeatherModel v) => v.unitSettings;
  static const Field<CurrentWeatherModel, UnitSettings> _f$unitSettings =
      Field('unitSettings', _$unitSettings);

  @override
  final MappableFields<CurrentWeatherModel> fields = const {
    #temp: _f$temp,
    #feelsLike: _f$feelsLike,
    #windSpeed: _f$windSpeed,
    #condition: _f$condition,
    #unitSettings: _f$unitSettings,
  };

  static CurrentWeatherModel _instantiate(DecodingData data) {
    return CurrentWeatherModel(
        temp: data.dec(_f$temp),
        feelsLike: data.dec(_f$feelsLike),
        windSpeed: data.dec(_f$windSpeed),
        condition: data.dec(_f$condition),
        unitSettings: data.dec(_f$unitSettings));
  }

  @override
  final Function instantiate = _instantiate;

  static CurrentWeatherModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CurrentWeatherModel>(map);
  }

  static CurrentWeatherModel fromJson(String json) {
    return ensureInitialized().decodeJson<CurrentWeatherModel>(json);
  }
}

mixin CurrentWeatherModelMappable {
  String toJson() {
    return CurrentWeatherModelMapper.ensureInitialized()
        .encodeJson<CurrentWeatherModel>(this as CurrentWeatherModel);
  }

  Map<String, dynamic> toMap() {
    return CurrentWeatherModelMapper.ensureInitialized()
        .encodeMap<CurrentWeatherModel>(this as CurrentWeatherModel);
  }

  CurrentWeatherModelCopyWith<CurrentWeatherModel, CurrentWeatherModel,
          CurrentWeatherModel>
      get copyWith => _CurrentWeatherModelCopyWithImpl(
          this as CurrentWeatherModel, $identity, $identity);
  @override
  String toString() {
    return CurrentWeatherModelMapper.ensureInitialized()
        .stringifyValue(this as CurrentWeatherModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CurrentWeatherModelMapper.ensureInitialized()
                .isValueEqual(this as CurrentWeatherModel, other));
  }

  @override
  int get hashCode {
    return CurrentWeatherModelMapper.ensureInitialized()
        .hashValue(this as CurrentWeatherModel);
  }
}

extension CurrentWeatherModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrentWeatherModel, $Out> {
  CurrentWeatherModelCopyWith<$R, CurrentWeatherModel, $Out>
      get $asCurrentWeatherModel =>
          $base.as((v, t, t2) => _CurrentWeatherModelCopyWithImpl(v, t, t2));
}

abstract class CurrentWeatherModelCopyWith<$R, $In extends CurrentWeatherModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  UnitSettingsCopyWith<$R, UnitSettings, UnitSettings> get unitSettings;
  $R call(
      {int? temp,
      int? feelsLike,
      int? windSpeed,
      String? condition,
      UnitSettings? unitSettings});
  CurrentWeatherModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CurrentWeatherModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrentWeatherModel, $Out>
    implements CurrentWeatherModelCopyWith<$R, CurrentWeatherModel, $Out> {
  _CurrentWeatherModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrentWeatherModel> $mapper =
      CurrentWeatherModelMapper.ensureInitialized();
  @override
  UnitSettingsCopyWith<$R, UnitSettings, UnitSettings> get unitSettings =>
      $value.unitSettings.copyWith.$chain((v) => call(unitSettings: v));
  @override
  $R call(
          {int? temp,
          int? feelsLike,
          int? windSpeed,
          String? condition,
          UnitSettings? unitSettings}) =>
      $apply(FieldCopyWithData({
        if (temp != null) #temp: temp,
        if (feelsLike != null) #feelsLike: feelsLike,
        if (windSpeed != null) #windSpeed: windSpeed,
        if (condition != null) #condition: condition,
        if (unitSettings != null) #unitSettings: unitSettings
      }));
  @override
  CurrentWeatherModel $make(CopyWithData data) => CurrentWeatherModel(
      temp: data.get(#temp, or: $value.temp),
      feelsLike: data.get(#feelsLike, or: $value.feelsLike),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed),
      condition: data.get(#condition, or: $value.condition),
      unitSettings: data.get(#unitSettings, or: $value.unitSettings));

  @override
  CurrentWeatherModelCopyWith<$R2, CurrentWeatherModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CurrentWeatherModelCopyWithImpl($value, $cast, t);
}
