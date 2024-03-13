// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_data_model.dart';

class WeatherResponseModelMapper extends ClassMapperBase<WeatherResponseModel> {
  WeatherResponseModelMapper._();

  static WeatherResponseModelMapper? _instance;
  static WeatherResponseModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherResponseModelMapper._());
      CurrentDataMapper.ensureInitialized();
      DailyDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherResponseModel';

  static CurrentData _$currentCondition(WeatherResponseModel v) =>
      v.currentCondition;
  static const Field<WeatherResponseModel, CurrentData> _f$currentCondition =
      Field('currentCondition', _$currentCondition);
  static List<DailyData> _$days(WeatherResponseModel v) => v.days;
  static const Field<WeatherResponseModel, List<DailyData>> _f$days =
      Field('days', _$days);
  static String _$description(WeatherResponseModel v) => v.description;
  static const Field<WeatherResponseModel, String> _f$description =
      Field('description', _$description);
  static num? _$queryCost(WeatherResponseModel v) => v.queryCost;
  static const Field<WeatherResponseModel, num> _f$queryCost =
      Field('queryCost', _$queryCost, opt: true);
  static double? _$latitude(WeatherResponseModel v) => v.latitude;
  static const Field<WeatherResponseModel, double> _f$latitude =
      Field('latitude', _$latitude, opt: true);
  static double? _$longitude(WeatherResponseModel v) => v.longitude;
  static const Field<WeatherResponseModel, double> _f$longitude =
      Field('longitude', _$longitude, opt: true);
  static String? _$resolvedAddress(WeatherResponseModel v) => v.resolvedAddress;
  static const Field<WeatherResponseModel, String> _f$resolvedAddress =
      Field('resolvedAddress', _$resolvedAddress, opt: true);
  static String? _$address(WeatherResponseModel v) => v.address;
  static const Field<WeatherResponseModel, String> _f$address =
      Field('address', _$address, opt: true);
  static String? _$timezone(WeatherResponseModel v) => v.timezone;
  static const Field<WeatherResponseModel, String> _f$timezone =
      Field('timezone', _$timezone, opt: true);
  static int? _$tzoffset(WeatherResponseModel v) => v.tzoffset;
  static const Field<WeatherResponseModel, int> _f$tzoffset =
      Field('tzoffset', _$tzoffset, opt: true);

  @override
  final MappableFields<WeatherResponseModel> fields = const {
    #currentCondition: _f$currentCondition,
    #days: _f$days,
    #description: _f$description,
    #queryCost: _f$queryCost,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #resolvedAddress: _f$resolvedAddress,
    #address: _f$address,
    #timezone: _f$timezone,
    #tzoffset: _f$tzoffset,
  };

  static WeatherResponseModel _instantiate(DecodingData data) {
    return WeatherResponseModel(
        currentCondition: data.dec(_f$currentCondition),
        days: data.dec(_f$days),
        description: data.dec(_f$description),
        queryCost: data.dec(_f$queryCost),
        latitude: data.dec(_f$latitude),
        longitude: data.dec(_f$longitude),
        resolvedAddress: data.dec(_f$resolvedAddress),
        address: data.dec(_f$address),
        timezone: data.dec(_f$timezone),
        tzoffset: data.dec(_f$tzoffset));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherResponseModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherResponseModel>(map);
  }

  static WeatherResponseModel fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherResponseModel>(json);
  }
}

mixin WeatherResponseModelMappable {
  String toJson() {
    return WeatherResponseModelMapper.ensureInitialized()
        .encodeJson<WeatherResponseModel>(this as WeatherResponseModel);
  }

  Map<String, dynamic> toMap() {
    return WeatherResponseModelMapper.ensureInitialized()
        .encodeMap<WeatherResponseModel>(this as WeatherResponseModel);
  }

  WeatherResponseModelCopyWith<WeatherResponseModel, WeatherResponseModel,
          WeatherResponseModel>
      get copyWith => _WeatherResponseModelCopyWithImpl(
          this as WeatherResponseModel, $identity, $identity);
  @override
  String toString() {
    return WeatherResponseModelMapper.ensureInitialized()
        .stringifyValue(this as WeatherResponseModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherResponseModelMapper.ensureInitialized()
                .isValueEqual(this as WeatherResponseModel, other));
  }

  @override
  int get hashCode {
    return WeatherResponseModelMapper.ensureInitialized()
        .hashValue(this as WeatherResponseModel);
  }
}

extension WeatherResponseModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherResponseModel, $Out> {
  WeatherResponseModelCopyWith<$R, WeatherResponseModel, $Out>
      get $asWeatherResponseModel =>
          $base.as((v, t, t2) => _WeatherResponseModelCopyWithImpl(v, t, t2));
}

abstract class WeatherResponseModelCopyWith<
    $R,
    $In extends WeatherResponseModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  CurrentDataCopyWith<$R, CurrentData, CurrentData> get currentCondition;
  ListCopyWith<$R, DailyData, DailyDataCopyWith<$R, DailyData, DailyData>>
      get days;
  $R call(
      {CurrentData? currentCondition,
      List<DailyData>? days,
      String? description,
      num? queryCost,
      double? latitude,
      double? longitude,
      String? resolvedAddress,
      String? address,
      String? timezone,
      int? tzoffset});
  WeatherResponseModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WeatherResponseModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherResponseModel, $Out>
    implements WeatherResponseModelCopyWith<$R, WeatherResponseModel, $Out> {
  _WeatherResponseModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherResponseModel> $mapper =
      WeatherResponseModelMapper.ensureInitialized();
  @override
  CurrentDataCopyWith<$R, CurrentData, CurrentData> get currentCondition =>
      $value.currentCondition.copyWith.$chain((v) => call(currentCondition: v));
  @override
  ListCopyWith<$R, DailyData, DailyDataCopyWith<$R, DailyData, DailyData>>
      get days => ListCopyWith(
          $value.days, (v, t) => v.copyWith.$chain(t), (v) => call(days: v));
  @override
  $R call(
          {CurrentData? currentCondition,
          List<DailyData>? days,
          String? description,
          Object? queryCost = $none,
          Object? latitude = $none,
          Object? longitude = $none,
          Object? resolvedAddress = $none,
          Object? address = $none,
          Object? timezone = $none,
          Object? tzoffset = $none}) =>
      $apply(FieldCopyWithData({
        if (currentCondition != null) #currentCondition: currentCondition,
        if (days != null) #days: days,
        if (description != null) #description: description,
        if (queryCost != $none) #queryCost: queryCost,
        if (latitude != $none) #latitude: latitude,
        if (longitude != $none) #longitude: longitude,
        if (resolvedAddress != $none) #resolvedAddress: resolvedAddress,
        if (address != $none) #address: address,
        if (timezone != $none) #timezone: timezone,
        if (tzoffset != $none) #tzoffset: tzoffset
      }));
  @override
  WeatherResponseModel $make(CopyWithData data) => WeatherResponseModel(
      currentCondition:
          data.get(#currentCondition, or: $value.currentCondition),
      days: data.get(#days, or: $value.days),
      description: data.get(#description, or: $value.description),
      queryCost: data.get(#queryCost, or: $value.queryCost),
      latitude: data.get(#latitude, or: $value.latitude),
      longitude: data.get(#longitude, or: $value.longitude),
      resolvedAddress: data.get(#resolvedAddress, or: $value.resolvedAddress),
      address: data.get(#address, or: $value.address),
      timezone: data.get(#timezone, or: $value.timezone),
      tzoffset: data.get(#tzoffset, or: $value.tzoffset));

  @override
  WeatherResponseModelCopyWith<$R2, WeatherResponseModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _WeatherResponseModelCopyWithImpl($value, $cast, t);
}
