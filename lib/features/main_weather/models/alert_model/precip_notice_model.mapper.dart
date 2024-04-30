// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'precip_notice_model.dart';

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

class PrecipNoticeModelMapper extends ClassMapperBase<PrecipNoticeModel> {
  PrecipNoticeModelMapper._();

  static PrecipNoticeModelMapper? _instance;
  static PrecipNoticeModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrecipNoticeModelMapper._());
      PrecipNoticeTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PrecipNoticeModel';

  static PrecipNoticeType _$precipAlertType(PrecipNoticeModel v) =>
      v.precipAlertType;
  static const Field<PrecipNoticeModel, PrecipNoticeType> _f$precipAlertType =
      Field('precipAlertType', _$precipAlertType);
  static String _$precipNoticeIconPath(PrecipNoticeModel v) =>
      v.precipNoticeIconPath;
  static const Field<PrecipNoticeModel, String> _f$precipNoticeIconPath =
      Field('precipNoticeIconPath', _$precipNoticeIconPath);
  static String _$precipNoticeMessage(PrecipNoticeModel v) =>
      v.precipNoticeMessage;
  static const Field<PrecipNoticeModel, String> _f$precipNoticeMessage =
      Field('precipNoticeMessage', _$precipNoticeMessage);

  @override
  final MappableFields<PrecipNoticeModel> fields = const {
    #precipAlertType: _f$precipAlertType,
    #precipNoticeIconPath: _f$precipNoticeIconPath,
    #precipNoticeMessage: _f$precipNoticeMessage,
  };

  static PrecipNoticeModel _instantiate(DecodingData data) {
    return PrecipNoticeModel(
        precipAlertType: data.dec(_f$precipAlertType),
        precipNoticeIconPath: data.dec(_f$precipNoticeIconPath),
        precipNoticeMessage: data.dec(_f$precipNoticeMessage));
  }

  @override
  final Function instantiate = _instantiate;

  static PrecipNoticeModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrecipNoticeModel>(map);
  }

  static PrecipNoticeModel fromJson(String json) {
    return ensureInitialized().decodeJson<PrecipNoticeModel>(json);
  }
}

mixin PrecipNoticeModelMappable {
  String toJson() {
    return PrecipNoticeModelMapper.ensureInitialized()
        .encodeJson<PrecipNoticeModel>(this as PrecipNoticeModel);
  }

  Map<String, dynamic> toMap() {
    return PrecipNoticeModelMapper.ensureInitialized()
        .encodeMap<PrecipNoticeModel>(this as PrecipNoticeModel);
  }

  PrecipNoticeModelCopyWith<PrecipNoticeModel, PrecipNoticeModel,
          PrecipNoticeModel>
      get copyWith => _PrecipNoticeModelCopyWithImpl(
          this as PrecipNoticeModel, $identity, $identity);
  @override
  String toString() {
    return PrecipNoticeModelMapper.ensureInitialized()
        .stringifyValue(this as PrecipNoticeModel);
  }

  @override
  bool operator ==(Object other) {
    return PrecipNoticeModelMapper.ensureInitialized()
        .equalsValue(this as PrecipNoticeModel, other);
  }

  @override
  int get hashCode {
    return PrecipNoticeModelMapper.ensureInitialized()
        .hashValue(this as PrecipNoticeModel);
  }
}

extension PrecipNoticeModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrecipNoticeModel, $Out> {
  PrecipNoticeModelCopyWith<$R, PrecipNoticeModel, $Out>
      get $asPrecipNoticeModel =>
          $base.as((v, t, t2) => _PrecipNoticeModelCopyWithImpl(v, t, t2));
}

abstract class PrecipNoticeModelCopyWith<$R, $In extends PrecipNoticeModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {PrecipNoticeType? precipAlertType,
      String? precipNoticeIconPath,
      String? precipNoticeMessage});
  PrecipNoticeModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrecipNoticeModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrecipNoticeModel, $Out>
    implements PrecipNoticeModelCopyWith<$R, PrecipNoticeModel, $Out> {
  _PrecipNoticeModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrecipNoticeModel> $mapper =
      PrecipNoticeModelMapper.ensureInitialized();
  @override
  $R call(
          {PrecipNoticeType? precipAlertType,
          String? precipNoticeIconPath,
          String? precipNoticeMessage}) =>
      $apply(FieldCopyWithData({
        if (precipAlertType != null) #precipAlertType: precipAlertType,
        if (precipNoticeIconPath != null)
          #precipNoticeIconPath: precipNoticeIconPath,
        if (precipNoticeMessage != null)
          #precipNoticeMessage: precipNoticeMessage
      }));
  @override
  PrecipNoticeModel $make(CopyWithData data) => PrecipNoticeModel(
      precipAlertType: data.get(#precipAlertType, or: $value.precipAlertType),
      precipNoticeIconPath:
          data.get(#precipNoticeIconPath, or: $value.precipNoticeIconPath),
      precipNoticeMessage:
          data.get(#precipNoticeMessage, or: $value.precipNoticeMessage));

  @override
  PrecipNoticeModelCopyWith<$R2, PrecipNoticeModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PrecipNoticeModelCopyWithImpl($value, $cast, t);
}
