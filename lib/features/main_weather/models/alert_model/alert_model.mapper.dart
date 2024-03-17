// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'alert_model.dart';

class PrecipNoticeTypeMapper extends EnumMapper<PrecipNoticeType> {
  PrecipNoticeTypeMapper._();

  static PrecipNoticeTypeMapper? _instance;
  static PrecipNoticeTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrecipNoticeTypeMapper._());
    }
    return _instance!;
  }

  static PrecipNoticeType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  PrecipNoticeType decode(dynamic value) {
    switch (value) {
      case 'noPrecip':
        return PrecipNoticeType.noPrecip;
      case 'currentPrecip':
        return PrecipNoticeType.currentPrecip;
      case 'forecastedPrecip':
        return PrecipNoticeType.forecastedPrecip;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(PrecipNoticeType self) {
    switch (self) {
      case PrecipNoticeType.noPrecip:
        return 'noPrecip';
      case PrecipNoticeType.currentPrecip:
        return 'currentPrecip';
      case PrecipNoticeType.forecastedPrecip:
        return 'forecastedPrecip';
    }
  }
}

extension PrecipNoticeTypeMapperExtension on PrecipNoticeType {
  String toValue() {
    PrecipNoticeTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<PrecipNoticeType>(this) as String;
  }
}

class AlertModelMapper extends ClassMapperBase<AlertModel> {
  AlertModelMapper._();

  static AlertModelMapper? _instance;
  static AlertModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AlertModelMapper._());
      PrecipNoticeTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AlertModel';

  static PrecipNoticeType _$precipAlertType(AlertModel v) => v.precipAlertType;
  static const Field<AlertModel, PrecipNoticeType> _f$precipAlertType =
      Field('precipAlertType', _$precipAlertType);
  static String _$precipNoticeIconPath(AlertModel v) => v.precipNoticeIconPath;
  static const Field<AlertModel, String> _f$precipNoticeIconPath =
      Field('precipNoticeIconPath', _$precipNoticeIconPath, opt: true, def: '');
  static String _$precipNoticeMessage(AlertModel v) => v.precipNoticeMessage;
  static const Field<AlertModel, String> _f$precipNoticeMessage =
      Field('precipNoticeMessage', _$precipNoticeMessage, opt: true, def: '');
  static String _$weatherAlertMessage(AlertModel v) => v.weatherAlertMessage;
  static const Field<AlertModel, String> _f$weatherAlertMessage =
      Field('weatherAlertMessage', _$weatherAlertMessage, opt: true, def: '');

  @override
  final MappableFields<AlertModel> fields = const {
    #precipAlertType: _f$precipAlertType,
    #precipNoticeIconPath: _f$precipNoticeIconPath,
    #precipNoticeMessage: _f$precipNoticeMessage,
    #weatherAlertMessage: _f$weatherAlertMessage,
  };

  static AlertModel _instantiate(DecodingData data) {
    return AlertModel(
        precipAlertType: data.dec(_f$precipAlertType),
        precipNoticeIconPath: data.dec(_f$precipNoticeIconPath),
        precipNoticeMessage: data.dec(_f$precipNoticeMessage),
        weatherAlertMessage: data.dec(_f$weatherAlertMessage));
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
  $R call(
      {PrecipNoticeType? precipAlertType,
      String? precipNoticeIconPath,
      String? precipNoticeMessage,
      String? weatherAlertMessage});
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
  $R call(
          {PrecipNoticeType? precipAlertType,
          String? precipNoticeIconPath,
          String? precipNoticeMessage,
          String? weatherAlertMessage}) =>
      $apply(FieldCopyWithData({
        if (precipAlertType != null) #precipAlertType: precipAlertType,
        if (precipNoticeIconPath != null)
          #precipNoticeIconPath: precipNoticeIconPath,
        if (precipNoticeMessage != null)
          #precipNoticeMessage: precipNoticeMessage,
        if (weatherAlertMessage != null)
          #weatherAlertMessage: weatherAlertMessage
      }));
  @override
  AlertModel $make(CopyWithData data) => AlertModel(
      precipAlertType: data.get(#precipAlertType, or: $value.precipAlertType),
      precipNoticeIconPath:
          data.get(#precipNoticeIconPath, or: $value.precipNoticeIconPath),
      precipNoticeMessage:
          data.get(#precipNoticeMessage, or: $value.precipNoticeMessage),
      weatherAlertMessage:
          data.get(#weatherAlertMessage, or: $value.weatherAlertMessage));

  @override
  AlertModelCopyWith<$R2, AlertModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AlertModelCopyWithImpl($value, $cast, t);
}
