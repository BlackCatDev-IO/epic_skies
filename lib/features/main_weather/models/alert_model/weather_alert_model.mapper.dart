// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_alert_model.dart';

class WeatherAlertModelMapper extends ClassMapperBase<WeatherAlertModel> {
  WeatherAlertModelMapper._();

  static WeatherAlertModelMapper? _instance;
  static WeatherAlertModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherAlertModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherAlertModel';

  static String _$weatherAlertMessage(WeatherAlertModel v) =>
      v.weatherAlertMessage;
  static const Field<WeatherAlertModel, String> _f$weatherAlertMessage =
      Field('weatherAlertMessage', _$weatherAlertMessage);
  static String _$alertSource(WeatherAlertModel v) => v.alertSource;
  static const Field<WeatherAlertModel, String> _f$alertSource =
      Field('alertSource', _$alertSource);
  static String _$alertAreaName(WeatherAlertModel v) => v.alertAreaName;
  static const Field<WeatherAlertModel, String> _f$alertAreaName =
      Field('alertAreaName', _$alertAreaName);
  static String _$detailsUrl(WeatherAlertModel v) => v.detailsUrl;
  static const Field<WeatherAlertModel, String> _f$detailsUrl =
      Field('detailsUrl', _$detailsUrl);

  @override
  final MappableFields<WeatherAlertModel> fields = const {
    #weatherAlertMessage: _f$weatherAlertMessage,
    #alertSource: _f$alertSource,
    #alertAreaName: _f$alertAreaName,
    #detailsUrl: _f$detailsUrl,
  };

  static WeatherAlertModel _instantiate(DecodingData data) {
    return WeatherAlertModel(
        weatherAlertMessage: data.dec(_f$weatherAlertMessage),
        alertSource: data.dec(_f$alertSource),
        alertAreaName: data.dec(_f$alertAreaName),
        detailsUrl: data.dec(_f$detailsUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherAlertModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherAlertModel>(map);
  }

  static WeatherAlertModel fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherAlertModel>(json);
  }
}

mixin WeatherAlertModelMappable {
  String toJson() {
    return WeatherAlertModelMapper.ensureInitialized()
        .encodeJson<WeatherAlertModel>(this as WeatherAlertModel);
  }

  Map<String, dynamic> toMap() {
    return WeatherAlertModelMapper.ensureInitialized()
        .encodeMap<WeatherAlertModel>(this as WeatherAlertModel);
  }

  WeatherAlertModelCopyWith<WeatherAlertModel, WeatherAlertModel,
          WeatherAlertModel>
      get copyWith => _WeatherAlertModelCopyWithImpl(
          this as WeatherAlertModel, $identity, $identity);
  @override
  String toString() {
    return WeatherAlertModelMapper.ensureInitialized()
        .stringifyValue(this as WeatherAlertModel);
  }

  @override
  bool operator ==(Object other) {
    return WeatherAlertModelMapper.ensureInitialized()
        .equalsValue(this as WeatherAlertModel, other);
  }

  @override
  int get hashCode {
    return WeatherAlertModelMapper.ensureInitialized()
        .hashValue(this as WeatherAlertModel);
  }
}

extension WeatherAlertModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherAlertModel, $Out> {
  WeatherAlertModelCopyWith<$R, WeatherAlertModel, $Out>
      get $asWeatherAlertModel =>
          $base.as((v, t, t2) => _WeatherAlertModelCopyWithImpl(v, t, t2));
}

abstract class WeatherAlertModelCopyWith<$R, $In extends WeatherAlertModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? weatherAlertMessage,
      String? alertSource,
      String? alertAreaName,
      String? detailsUrl});
  WeatherAlertModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WeatherAlertModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherAlertModel, $Out>
    implements WeatherAlertModelCopyWith<$R, WeatherAlertModel, $Out> {
  _WeatherAlertModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherAlertModel> $mapper =
      WeatherAlertModelMapper.ensureInitialized();
  @override
  $R call(
          {String? weatherAlertMessage,
          String? alertSource,
          String? alertAreaName,
          String? detailsUrl}) =>
      $apply(FieldCopyWithData({
        if (weatherAlertMessage != null)
          #weatherAlertMessage: weatherAlertMessage,
        if (alertSource != null) #alertSource: alertSource,
        if (alertAreaName != null) #alertAreaName: alertAreaName,
        if (detailsUrl != null) #detailsUrl: detailsUrl
      }));
  @override
  WeatherAlertModel $make(CopyWithData data) => WeatherAlertModel(
      weatherAlertMessage:
          data.get(#weatherAlertMessage, or: $value.weatherAlertMessage),
      alertSource: data.get(#alertSource, or: $value.alertSource),
      alertAreaName: data.get(#alertAreaName, or: $value.alertAreaName),
      detailsUrl: data.get(#detailsUrl, or: $value.detailsUrl));

  @override
  WeatherAlertModelCopyWith<$R2, WeatherAlertModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WeatherAlertModelCopyWithImpl($value, $cast, t);
}
