// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hourly_forecast_model.dart';

class HourlyForecastModelMapper extends ClassMapperBase<HourlyForecastModel> {
  HourlyForecastModelMapper._();

  static HourlyForecastModelMapper? _instance;
  static HourlyForecastModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HourlyForecastModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HourlyForecastModel';

  static int _$temp(HourlyForecastModel v) => v.temp;
  static const Field<HourlyForecastModel, int> _f$temp = Field('temp', _$temp);
  static int _$feelsLike(HourlyForecastModel v) => v.feelsLike;
  static const Field<HourlyForecastModel, int> _f$feelsLike =
      Field('feelsLike', _$feelsLike);
  static num _$precipitationAmount(HourlyForecastModel v) =>
      v.precipitationAmount;
  static const Field<HourlyForecastModel, num> _f$precipitationAmount =
      Field('precipitationAmount', _$precipitationAmount);
  static num _$precipitationProbability(HourlyForecastModel v) =>
      v.precipitationProbability;
  static const Field<HourlyForecastModel, num> _f$precipitationProbability =
      Field('precipitationProbability', _$precipitationProbability);
  static int _$windSpeed(HourlyForecastModel v) => v.windSpeed;
  static const Field<HourlyForecastModel, int> _f$windSpeed =
      Field('windSpeed', _$windSpeed);
  static String _$iconPath(HourlyForecastModel v) => v.iconPath;
  static const Field<HourlyForecastModel, String> _f$iconPath =
      Field('iconPath', _$iconPath);
  static DateTime _$time(HourlyForecastModel v) => v.time;
  static const Field<HourlyForecastModel, DateTime> _f$time =
      Field('time', _$time);
  static String _$precipitationType(HourlyForecastModel v) =>
      v.precipitationType;
  static const Field<HourlyForecastModel, String> _f$precipitationType =
      Field('precipitationType', _$precipitationType);
  static String _$condition(HourlyForecastModel v) => v.condition;
  static const Field<HourlyForecastModel, String> _f$condition =
      Field('condition', _$condition);
  static String? _$suntimeString(HourlyForecastModel v) => v.suntimeString;
  static const Field<HourlyForecastModel, String> _f$suntimeString =
      Field('suntimeString', _$suntimeString, opt: true);
  static bool? _$isSunrise(HourlyForecastModel v) => v.isSunrise;
  static const Field<HourlyForecastModel, bool> _f$isSunrise =
      Field('isSunrise', _$isSunrise, opt: true);

  @override
  final MappableFields<HourlyForecastModel> fields = const {
    #temp: _f$temp,
    #feelsLike: _f$feelsLike,
    #precipitationAmount: _f$precipitationAmount,
    #precipitationProbability: _f$precipitationProbability,
    #windSpeed: _f$windSpeed,
    #iconPath: _f$iconPath,
    #time: _f$time,
    #precipitationType: _f$precipitationType,
    #condition: _f$condition,
    #suntimeString: _f$suntimeString,
    #isSunrise: _f$isSunrise,
  };

  static HourlyForecastModel _instantiate(DecodingData data) {
    return HourlyForecastModel(
        temp: data.dec(_f$temp),
        feelsLike: data.dec(_f$feelsLike),
        precipitationAmount: data.dec(_f$precipitationAmount),
        precipitationProbability: data.dec(_f$precipitationProbability),
        windSpeed: data.dec(_f$windSpeed),
        iconPath: data.dec(_f$iconPath),
        time: data.dec(_f$time),
        precipitationType: data.dec(_f$precipitationType),
        condition: data.dec(_f$condition),
        suntimeString: data.dec(_f$suntimeString),
        isSunrise: data.dec(_f$isSunrise));
  }

  @override
  final Function instantiate = _instantiate;

  static HourlyForecastModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HourlyForecastModel>(map);
  }

  static HourlyForecastModel fromJson(String json) {
    return ensureInitialized().decodeJson<HourlyForecastModel>(json);
  }
}

mixin HourlyForecastModelMappable {
  String toJson() {
    return HourlyForecastModelMapper.ensureInitialized()
        .encodeJson<HourlyForecastModel>(this as HourlyForecastModel);
  }

  Map<String, dynamic> toMap() {
    return HourlyForecastModelMapper.ensureInitialized()
        .encodeMap<HourlyForecastModel>(this as HourlyForecastModel);
  }

  HourlyForecastModelCopyWith<HourlyForecastModel, HourlyForecastModel,
          HourlyForecastModel>
      get copyWith => _HourlyForecastModelCopyWithImpl(
          this as HourlyForecastModel, $identity, $identity);
  @override
  String toString() {
    return HourlyForecastModelMapper.ensureInitialized()
        .stringifyValue(this as HourlyForecastModel);
  }

  @override
  bool operator ==(Object other) {
    return HourlyForecastModelMapper.ensureInitialized()
        .equalsValue(this as HourlyForecastModel, other);
  }

  @override
  int get hashCode {
    return HourlyForecastModelMapper.ensureInitialized()
        .hashValue(this as HourlyForecastModel);
  }
}

extension HourlyForecastModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HourlyForecastModel, $Out> {
  HourlyForecastModelCopyWith<$R, HourlyForecastModel, $Out>
      get $asHourlyForecastModel =>
          $base.as((v, t, t2) => _HourlyForecastModelCopyWithImpl(v, t, t2));
}

abstract class HourlyForecastModelCopyWith<$R, $In extends HourlyForecastModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? temp,
      int? feelsLike,
      num? precipitationAmount,
      num? precipitationProbability,
      int? windSpeed,
      String? iconPath,
      DateTime? time,
      String? precipitationType,
      String? condition,
      String? suntimeString,
      bool? isSunrise});
  HourlyForecastModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HourlyForecastModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HourlyForecastModel, $Out>
    implements HourlyForecastModelCopyWith<$R, HourlyForecastModel, $Out> {
  _HourlyForecastModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HourlyForecastModel> $mapper =
      HourlyForecastModelMapper.ensureInitialized();
  @override
  $R call(
          {int? temp,
          int? feelsLike,
          num? precipitationAmount,
          num? precipitationProbability,
          int? windSpeed,
          String? iconPath,
          DateTime? time,
          String? precipitationType,
          String? condition,
          Object? suntimeString = $none,
          Object? isSunrise = $none}) =>
      $apply(FieldCopyWithData({
        if (temp != null) #temp: temp,
        if (feelsLike != null) #feelsLike: feelsLike,
        if (precipitationAmount != null)
          #precipitationAmount: precipitationAmount,
        if (precipitationProbability != null)
          #precipitationProbability: precipitationProbability,
        if (windSpeed != null) #windSpeed: windSpeed,
        if (iconPath != null) #iconPath: iconPath,
        if (time != null) #time: time,
        if (precipitationType != null) #precipitationType: precipitationType,
        if (condition != null) #condition: condition,
        if (suntimeString != $none) #suntimeString: suntimeString,
        if (isSunrise != $none) #isSunrise: isSunrise
      }));
  @override
  HourlyForecastModel $make(CopyWithData data) => HourlyForecastModel(
      temp: data.get(#temp, or: $value.temp),
      feelsLike: data.get(#feelsLike, or: $value.feelsLike),
      precipitationAmount:
          data.get(#precipitationAmount, or: $value.precipitationAmount),
      precipitationProbability: data.get(#precipitationProbability,
          or: $value.precipitationProbability),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed),
      iconPath: data.get(#iconPath, or: $value.iconPath),
      time: data.get(#time, or: $value.time),
      precipitationType:
          data.get(#precipitationType, or: $value.precipitationType),
      condition: data.get(#condition, or: $value.condition),
      suntimeString: data.get(#suntimeString, or: $value.suntimeString),
      isSunrise: data.get(#isSunrise, or: $value.isSunrise));

  @override
  HourlyForecastModelCopyWith<$R2, HourlyForecastModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HourlyForecastModelCopyWithImpl($value, $cast, t);
}
