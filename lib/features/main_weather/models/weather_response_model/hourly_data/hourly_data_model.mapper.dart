// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hourly_data_model.dart';

class HourlyDataMapper extends ClassMapperBase<HourlyData> {
  HourlyDataMapper._();

  static HourlyDataMapper? _instance;
  static HourlyDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HourlyDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HourlyData';

  static int _$datetimeEpoch(HourlyData v) => v.datetimeEpoch;
  static const Field<HourlyData, int> _f$datetimeEpoch =
      Field('datetimeEpoch', _$datetimeEpoch);
  static num _$temp(HourlyData v) => v.temp;
  static const Field<HourlyData, num> _f$temp = Field('temp', _$temp);
  static num _$feelslike(HourlyData v) => v.feelslike;
  static const Field<HourlyData, num> _f$feelslike =
      Field('feelslike', _$feelslike);
  static String _$conditions(HourlyData v) => v.conditions;
  static const Field<HourlyData, String> _f$conditions =
      Field('conditions', _$conditions);
  static num? _$windspeed(HourlyData v) => v.windspeed;
  static const Field<HourlyData, num> _f$windspeed =
      Field('windspeed', _$windspeed, opt: true);
  static double? _$humidity(HourlyData v) => v.humidity;
  static const Field<HourlyData, double> _f$humidity =
      Field('humidity', _$humidity, opt: true);
  static double? _$dew(HourlyData v) => v.dew;
  static const Field<HourlyData, double> _f$dew =
      Field('dew', _$dew, opt: true);
  static num? _$precip(HourlyData v) => v.precip;
  static const Field<HourlyData, num> _f$precip =
      Field('precip', _$precip, opt: true);
  static num? _$precipprob(HourlyData v) => v.precipprob;
  static const Field<HourlyData, num> _f$precipprob =
      Field('precipprob', _$precipprob, opt: true);
  static num? _$snow(HourlyData v) => v.snow;
  static const Field<HourlyData, num> _f$snow =
      Field('snow', _$snow, opt: true);
  static double? _$snowdepth(HourlyData v) => v.snowdepth;
  static const Field<HourlyData, double> _f$snowdepth =
      Field('snowdepth', _$snowdepth, opt: true);
  static List<dynamic>? _$preciptype(HourlyData v) => v.preciptype;
  static const Field<HourlyData, List<dynamic>> _f$preciptype =
      Field('preciptype', _$preciptype, opt: true);
  static double? _$windgust(HourlyData v) => v.windgust;
  static const Field<HourlyData, double> _f$windgust =
      Field('windgust', _$windgust, opt: true);
  static double? _$winddir(HourlyData v) => v.winddir;
  static const Field<HourlyData, double> _f$winddir =
      Field('winddir', _$winddir, opt: true);
  static double? _$pressure(HourlyData v) => v.pressure;
  static const Field<HourlyData, double> _f$pressure =
      Field('pressure', _$pressure, opt: true);
  static double? _$visibility(HourlyData v) => v.visibility;
  static const Field<HourlyData, double> _f$visibility =
      Field('visibility', _$visibility, opt: true);
  static double? _$cloudcover(HourlyData v) => v.cloudcover;
  static const Field<HourlyData, double> _f$cloudcover =
      Field('cloudcover', _$cloudcover, opt: true);
  static double? _$solarradiation(HourlyData v) => v.solarradiation;
  static const Field<HourlyData, double> _f$solarradiation =
      Field('solarradiation', _$solarradiation, opt: true);
  static double? _$solarenergy(HourlyData v) => v.solarenergy;
  static const Field<HourlyData, double> _f$solarenergy =
      Field('solarenergy', _$solarenergy, opt: true);
  static num? _$uvindex(HourlyData v) => v.uvindex;
  static const Field<HourlyData, num> _f$uvindex =
      Field('uvindex', _$uvindex, opt: true);
  static num? _$severerisk(HourlyData v) => v.severerisk;
  static const Field<HourlyData, num> _f$severerisk =
      Field('severerisk', _$severerisk, opt: true);
  static String? _$icon(HourlyData v) => v.icon;
  static const Field<HourlyData, String> _f$icon =
      Field('icon', _$icon, opt: true);
  static String? _$source(HourlyData v) => v.source;
  static const Field<HourlyData, String> _f$source =
      Field('source', _$source, opt: true);

  @override
  final MappableFields<HourlyData> fields = const {
    #datetimeEpoch: _f$datetimeEpoch,
    #temp: _f$temp,
    #feelslike: _f$feelslike,
    #conditions: _f$conditions,
    #windspeed: _f$windspeed,
    #humidity: _f$humidity,
    #dew: _f$dew,
    #precip: _f$precip,
    #precipprob: _f$precipprob,
    #snow: _f$snow,
    #snowdepth: _f$snowdepth,
    #preciptype: _f$preciptype,
    #windgust: _f$windgust,
    #winddir: _f$winddir,
    #pressure: _f$pressure,
    #visibility: _f$visibility,
    #cloudcover: _f$cloudcover,
    #solarradiation: _f$solarradiation,
    #solarenergy: _f$solarenergy,
    #uvindex: _f$uvindex,
    #severerisk: _f$severerisk,
    #icon: _f$icon,
    #source: _f$source,
  };

  static HourlyData _instantiate(DecodingData data) {
    return HourlyData(
        datetimeEpoch: data.dec(_f$datetimeEpoch),
        temp: data.dec(_f$temp),
        feelslike: data.dec(_f$feelslike),
        conditions: data.dec(_f$conditions),
        windspeed: data.dec(_f$windspeed),
        humidity: data.dec(_f$humidity),
        dew: data.dec(_f$dew),
        precip: data.dec(_f$precip),
        precipprob: data.dec(_f$precipprob),
        snow: data.dec(_f$snow),
        snowdepth: data.dec(_f$snowdepth),
        preciptype: data.dec(_f$preciptype),
        windgust: data.dec(_f$windgust),
        winddir: data.dec(_f$winddir),
        pressure: data.dec(_f$pressure),
        visibility: data.dec(_f$visibility),
        cloudcover: data.dec(_f$cloudcover),
        solarradiation: data.dec(_f$solarradiation),
        solarenergy: data.dec(_f$solarenergy),
        uvindex: data.dec(_f$uvindex),
        severerisk: data.dec(_f$severerisk),
        icon: data.dec(_f$icon),
        source: data.dec(_f$source));
  }

  @override
  final Function instantiate = _instantiate;

  static HourlyData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HourlyData>(map);
  }

  static HourlyData fromJson(String json) {
    return ensureInitialized().decodeJson<HourlyData>(json);
  }
}

mixin HourlyDataMappable {
  String toJson() {
    return HourlyDataMapper.ensureInitialized()
        .encodeJson<HourlyData>(this as HourlyData);
  }

  Map<String, dynamic> toMap() {
    return HourlyDataMapper.ensureInitialized()
        .encodeMap<HourlyData>(this as HourlyData);
  }

  HourlyDataCopyWith<HourlyData, HourlyData, HourlyData> get copyWith =>
      _HourlyDataCopyWithImpl(this as HourlyData, $identity, $identity);
  @override
  String toString() {
    return HourlyDataMapper.ensureInitialized()
        .stringifyValue(this as HourlyData);
  }

  @override
  bool operator ==(Object other) {
    return HourlyDataMapper.ensureInitialized()
        .equalsValue(this as HourlyData, other);
  }

  @override
  int get hashCode {
    return HourlyDataMapper.ensureInitialized().hashValue(this as HourlyData);
  }
}

extension HourlyDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HourlyData, $Out> {
  HourlyDataCopyWith<$R, HourlyData, $Out> get $asHourlyData =>
      $base.as((v, t, t2) => _HourlyDataCopyWithImpl(v, t, t2));
}

abstract class HourlyDataCopyWith<$R, $In extends HourlyData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get preciptype;
  $R call(
      {int? datetimeEpoch,
      num? temp,
      num? feelslike,
      String? conditions,
      num? windspeed,
      double? humidity,
      double? dew,
      num? precip,
      num? precipprob,
      num? snow,
      double? snowdepth,
      List<dynamic>? preciptype,
      double? windgust,
      double? winddir,
      double? pressure,
      double? visibility,
      double? cloudcover,
      double? solarradiation,
      double? solarenergy,
      num? uvindex,
      num? severerisk,
      String? icon,
      String? source});
  HourlyDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HourlyDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HourlyData, $Out>
    implements HourlyDataCopyWith<$R, HourlyData, $Out> {
  _HourlyDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HourlyData> $mapper =
      HourlyDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get preciptype => $value.preciptype != null
          ? ListCopyWith(
              $value.preciptype!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(preciptype: v))
          : null;
  @override
  $R call(
          {int? datetimeEpoch,
          num? temp,
          num? feelslike,
          String? conditions,
          Object? windspeed = $none,
          Object? humidity = $none,
          Object? dew = $none,
          Object? precip = $none,
          Object? precipprob = $none,
          Object? snow = $none,
          Object? snowdepth = $none,
          Object? preciptype = $none,
          Object? windgust = $none,
          Object? winddir = $none,
          Object? pressure = $none,
          Object? visibility = $none,
          Object? cloudcover = $none,
          Object? solarradiation = $none,
          Object? solarenergy = $none,
          Object? uvindex = $none,
          Object? severerisk = $none,
          Object? icon = $none,
          Object? source = $none}) =>
      $apply(FieldCopyWithData({
        if (datetimeEpoch != null) #datetimeEpoch: datetimeEpoch,
        if (temp != null) #temp: temp,
        if (feelslike != null) #feelslike: feelslike,
        if (conditions != null) #conditions: conditions,
        if (windspeed != $none) #windspeed: windspeed,
        if (humidity != $none) #humidity: humidity,
        if (dew != $none) #dew: dew,
        if (precip != $none) #precip: precip,
        if (precipprob != $none) #precipprob: precipprob,
        if (snow != $none) #snow: snow,
        if (snowdepth != $none) #snowdepth: snowdepth,
        if (preciptype != $none) #preciptype: preciptype,
        if (windgust != $none) #windgust: windgust,
        if (winddir != $none) #winddir: winddir,
        if (pressure != $none) #pressure: pressure,
        if (visibility != $none) #visibility: visibility,
        if (cloudcover != $none) #cloudcover: cloudcover,
        if (solarradiation != $none) #solarradiation: solarradiation,
        if (solarenergy != $none) #solarenergy: solarenergy,
        if (uvindex != $none) #uvindex: uvindex,
        if (severerisk != $none) #severerisk: severerisk,
        if (icon != $none) #icon: icon,
        if (source != $none) #source: source
      }));
  @override
  HourlyData $make(CopyWithData data) => HourlyData(
      datetimeEpoch: data.get(#datetimeEpoch, or: $value.datetimeEpoch),
      temp: data.get(#temp, or: $value.temp),
      feelslike: data.get(#feelslike, or: $value.feelslike),
      conditions: data.get(#conditions, or: $value.conditions),
      windspeed: data.get(#windspeed, or: $value.windspeed),
      humidity: data.get(#humidity, or: $value.humidity),
      dew: data.get(#dew, or: $value.dew),
      precip: data.get(#precip, or: $value.precip),
      precipprob: data.get(#precipprob, or: $value.precipprob),
      snow: data.get(#snow, or: $value.snow),
      snowdepth: data.get(#snowdepth, or: $value.snowdepth),
      preciptype: data.get(#preciptype, or: $value.preciptype),
      windgust: data.get(#windgust, or: $value.windgust),
      winddir: data.get(#winddir, or: $value.winddir),
      pressure: data.get(#pressure, or: $value.pressure),
      visibility: data.get(#visibility, or: $value.visibility),
      cloudcover: data.get(#cloudcover, or: $value.cloudcover),
      solarradiation: data.get(#solarradiation, or: $value.solarradiation),
      solarenergy: data.get(#solarenergy, or: $value.solarenergy),
      uvindex: data.get(#uvindex, or: $value.uvindex),
      severerisk: data.get(#severerisk, or: $value.severerisk),
      icon: data.get(#icon, or: $value.icon),
      source: data.get(#source, or: $value.source));

  @override
  HourlyDataCopyWith<$R2, HourlyData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _HourlyDataCopyWithImpl($value, $cast, t);
}
