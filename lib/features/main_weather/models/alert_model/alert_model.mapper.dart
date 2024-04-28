// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'alert_model.dart';

class AlertModelMapper extends ClassMapperBase<AlertModel> {
  AlertModelMapper._();

  static AlertModelMapper? _instance;
  static AlertModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlertModelMapper._());
      PrecipNoticeModelMapper.ensureInitialized();
      WeatherAlertModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AlertModel';

  static PrecipNoticeModel _$precipNotice(AlertModel v) => v.precipNotice;
  static const Field<AlertModel, PrecipNoticeModel> _f$precipNotice =
      Field('precipNotice', _$precipNotice);
  static WeatherAlertModel _$weatherAlert(AlertModel v) => v.weatherAlert;
  static const Field<AlertModel, WeatherAlertModel> _f$weatherAlert =
      Field('weatherAlert', _$weatherAlert);

  @override
  final MappableFields<AlertModel> fields = const {
    #precipNotice: _f$precipNotice,
    #weatherAlert: _f$weatherAlert,
  };

  static AlertModel _instantiate(DecodingData data) {
    return AlertModel(
        precipNotice: data.dec(_f$precipNotice),
        weatherAlert: data.dec(_f$weatherAlert));
  }

  @override
  final Function instantiate = _instantiate;

  static AlertModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AlertModel>(map);
  }

  static AlertModel fromJson(String json) {
    return ensureInitialized().decodeJson<AlertModel>(json);
  }
}

mixin AlertModelMappable {
  String toJson() {
    return AlertModelMapper.ensureInitialized()
        .encodeJson<AlertModel>(this as AlertModel);
  }

  Map<String, dynamic> toMap() {
    return AlertModelMapper.ensureInitialized()
        .encodeMap<AlertModel>(this as AlertModel);
  }

  AlertModelCopyWith<AlertModel, AlertModel, AlertModel> get copyWith =>
      _AlertModelCopyWithImpl(this as AlertModel, $identity, $identity);
  @override
  String toString() {
    return AlertModelMapper.ensureInitialized()
        .stringifyValue(this as AlertModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AlertModelMapper.ensureInitialized()
                .isValueEqual(this as AlertModel, other));
  }

  @override
  int get hashCode {
    return AlertModelMapper.ensureInitialized().hashValue(this as AlertModel);
  }
}

extension AlertModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AlertModel, $Out> {
  AlertModelCopyWith<$R, AlertModel, $Out> get $asAlertModel =>
      $base.as((v, t, t2) => _AlertModelCopyWithImpl(v, t, t2));
}

abstract class AlertModelCopyWith<$R, $In extends AlertModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PrecipNoticeModelCopyWith<$R, PrecipNoticeModel, PrecipNoticeModel>
      get precipNotice;
  WeatherAlertModelCopyWith<$R, WeatherAlertModel, WeatherAlertModel>
      get weatherAlert;
  $R call({PrecipNoticeModel? precipNotice, WeatherAlertModel? weatherAlert});
  AlertModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AlertModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AlertModel, $Out>
    implements AlertModelCopyWith<$R, AlertModel, $Out> {
  _AlertModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AlertModel> $mapper =
      AlertModelMapper.ensureInitialized();
  @override
  PrecipNoticeModelCopyWith<$R, PrecipNoticeModel, PrecipNoticeModel>
      get precipNotice =>
          $value.precipNotice.copyWith.$chain((v) => call(precipNotice: v));
  @override
  WeatherAlertModelCopyWith<$R, WeatherAlertModel, WeatherAlertModel>
      get weatherAlert =>
          $value.weatherAlert.copyWith.$chain((v) => call(weatherAlert: v));
  @override
  $R call({PrecipNoticeModel? precipNotice, WeatherAlertModel? weatherAlert}) =>
      $apply(FieldCopyWithData({
        if (precipNotice != null) #precipNotice: precipNotice,
        if (weatherAlert != null) #weatherAlert: weatherAlert
      }));
  @override
  AlertModel $make(CopyWithData data) => AlertModel(
      precipNotice: data.get(#precipNotice, or: $value.precipNotice),
      weatherAlert: data.get(#weatherAlert, or: $value.weatherAlert));

  @override
  AlertModelCopyWith<$R2, AlertModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AlertModelCopyWithImpl($value, $cast, t);
}
