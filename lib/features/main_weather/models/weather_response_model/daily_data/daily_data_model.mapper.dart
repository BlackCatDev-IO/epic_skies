// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'daily_data_model.dart';

class DailyDataMapper extends ClassMapperBase<DailyData> {
  DailyDataMapper._();

  static DailyDataMapper? _instance;
  static DailyDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyDataMapper._());
      HourlyDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DailyData';

  static int _$datetimeEpoch(DailyData v) => v.datetimeEpoch;
  static const Field<DailyData, int> _f$datetimeEpoch =
      Field('datetimeEpoch', _$datetimeEpoch);
  static String _$conditions(DailyData v) => v.conditions;
  static const Field<DailyData, String> _f$conditions =
      Field('conditions', _$conditions);
  static num _$temp(DailyData v) => v.temp;
  static const Field<DailyData, num> _f$temp = Field('temp', _$temp);
  static num _$feelslike(DailyData v) => v.feelslike;
  static const Field<DailyData, num> _f$feelslike =
      Field('feelslike', _$feelslike);
  static num? _$windspeed(DailyData v) => v.windspeed;
  static const Field<DailyData, num> _f$windspeed =
      Field('windspeed', _$windspeed, opt: true);
  static num? _$tempmax(DailyData v) => v.tempmax;
  static const Field<DailyData, num> _f$tempmax =
      Field('tempmax', _$tempmax, opt: true);
  static num? _$tempmin(DailyData v) => v.tempmin;
  static const Field<DailyData, num> _f$tempmin =
      Field('tempmin', _$tempmin, opt: true);
  static double? _$feelslikemax(DailyData v) => v.feelslikemax;
  static const Field<DailyData, double> _f$feelslikemax =
      Field('feelslikemax', _$feelslikemax, opt: true);
  static double? _$feelslikemin(DailyData v) => v.feelslikemin;
  static const Field<DailyData, double> _f$feelslikemin =
      Field('feelslikemin', _$feelslikemin, opt: true);
  static double? _$dew(DailyData v) => v.dew;
  static const Field<DailyData, double> _f$dew = Field('dew', _$dew, opt: true);
  static double? _$humidity(DailyData v) => v.humidity;
  static const Field<DailyData, double> _f$humidity =
      Field('humidity', _$humidity, opt: true);
  static double? _$precip(DailyData v) => v.precip;
  static const Field<DailyData, double> _f$precip =
      Field('precip', _$precip, opt: true);
  static double? _$precipprob(DailyData v) => v.precipprob;
  static const Field<DailyData, double> _f$precipprob =
      Field('precipprob', _$precipprob, opt: true);
  static double? _$precipcover(DailyData v) => v.precipcover;
  static const Field<DailyData, double> _f$precipcover =
      Field('precipcover', _$precipcover, opt: true);
  static List<dynamic>? _$preciptype(DailyData v) => v.preciptype;
  static const Field<DailyData, List<dynamic>> _f$preciptype =
      Field('preciptype', _$preciptype, opt: true);
  static num? _$snow(DailyData v) => v.snow;
  static const Field<DailyData, num> _f$snow = Field('snow', _$snow, opt: true);
  static num? _$snowdepth(DailyData v) => v.snowdepth;
  static const Field<DailyData, num> _f$snowdepth =
      Field('snowdepth', _$snowdepth, opt: true);
  static double? _$windgust(DailyData v) => v.windgust;
  static const Field<DailyData, double> _f$windgust =
      Field('windgust', _$windgust, opt: true);
  static double? _$winddir(DailyData v) => v.winddir;
  static const Field<DailyData, double> _f$winddir =
      Field('winddir', _$winddir, opt: true);
  static double? _$pressure(DailyData v) => v.pressure;
  static const Field<DailyData, double> _f$pressure =
      Field('pressure', _$pressure, opt: true);
  static double? _$cloudcover(DailyData v) => v.cloudcover;
  static const Field<DailyData, double> _f$cloudcover =
      Field('cloudcover', _$cloudcover, opt: true);
  static double? _$visibility(DailyData v) => v.visibility;
  static const Field<DailyData, double> _f$visibility =
      Field('visibility', _$visibility, opt: true);
  static double? _$solarradiation(DailyData v) => v.solarradiation;
  static const Field<DailyData, double> _f$solarradiation =
      Field('solarradiation', _$solarradiation, opt: true);
  static double? _$solarenergy(DailyData v) => v.solarenergy;
  static const Field<DailyData, double> _f$solarenergy =
      Field('solarenergy', _$solarenergy, opt: true);
  static num? _$uvindex(DailyData v) => v.uvindex;
  static const Field<DailyData, num> _f$uvindex =
      Field('uvindex', _$uvindex, opt: true);
  static num? _$severerisk(DailyData v) => v.severerisk;
  static const Field<DailyData, num> _f$severerisk =
      Field('severerisk', _$severerisk, opt: true);
  static num? _$sunriseEpoch(DailyData v) => v.sunriseEpoch;
  static const Field<DailyData, num> _f$sunriseEpoch =
      Field('sunriseEpoch', _$sunriseEpoch, opt: true);
  static num? _$sunsetEpoch(DailyData v) => v.sunsetEpoch;
  static const Field<DailyData, num> _f$sunsetEpoch =
      Field('sunsetEpoch', _$sunsetEpoch, opt: true);
  static double? _$moonphase(DailyData v) => v.moonphase;
  static const Field<DailyData, double> _f$moonphase =
      Field('moonphase', _$moonphase, opt: true);
  static String? _$description(DailyData v) => v.description;
  static const Field<DailyData, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$icon(DailyData v) => v.icon;
  static const Field<DailyData, String> _f$icon =
      Field('icon', _$icon, opt: true);
  static String? _$source(DailyData v) => v.source;
  static const Field<DailyData, String> _f$source =
      Field('source', _$source, opt: true);
  static List<HourlyData>? _$hours(DailyData v) => v.hours;
  static const Field<DailyData, List<HourlyData>> _f$hours =
      Field('hours', _$hours, opt: true);

  @override
  final MappableFields<DailyData> fields = const {
    #datetimeEpoch: _f$datetimeEpoch,
    #conditions: _f$conditions,
    #temp: _f$temp,
    #feelslike: _f$feelslike,
    #windspeed: _f$windspeed,
    #tempmax: _f$tempmax,
    #tempmin: _f$tempmin,
    #feelslikemax: _f$feelslikemax,
    #feelslikemin: _f$feelslikemin,
    #dew: _f$dew,
    #humidity: _f$humidity,
    #precip: _f$precip,
    #precipprob: _f$precipprob,
    #precipcover: _f$precipcover,
    #preciptype: _f$preciptype,
    #snow: _f$snow,
    #snowdepth: _f$snowdepth,
    #windgust: _f$windgust,
    #winddir: _f$winddir,
    #pressure: _f$pressure,
    #cloudcover: _f$cloudcover,
    #visibility: _f$visibility,
    #solarradiation: _f$solarradiation,
    #solarenergy: _f$solarenergy,
    #uvindex: _f$uvindex,
    #severerisk: _f$severerisk,
    #sunriseEpoch: _f$sunriseEpoch,
    #sunsetEpoch: _f$sunsetEpoch,
    #moonphase: _f$moonphase,
    #description: _f$description,
    #icon: _f$icon,
    #source: _f$source,
    #hours: _f$hours,
  };

  static DailyData _instantiate(DecodingData data) {
    return DailyData(
        datetimeEpoch: data.dec(_f$datetimeEpoch),
        conditions: data.dec(_f$conditions),
        temp: data.dec(_f$temp),
        feelslike: data.dec(_f$feelslike),
        windspeed: data.dec(_f$windspeed),
        tempmax: data.dec(_f$tempmax),
        tempmin: data.dec(_f$tempmin),
        feelslikemax: data.dec(_f$feelslikemax),
        feelslikemin: data.dec(_f$feelslikemin),
        dew: data.dec(_f$dew),
        humidity: data.dec(_f$humidity),
        precip: data.dec(_f$precip),
        precipprob: data.dec(_f$precipprob),
        precipcover: data.dec(_f$precipcover),
        preciptype: data.dec(_f$preciptype),
        snow: data.dec(_f$snow),
        snowdepth: data.dec(_f$snowdepth),
        windgust: data.dec(_f$windgust),
        winddir: data.dec(_f$winddir),
        pressure: data.dec(_f$pressure),
        cloudcover: data.dec(_f$cloudcover),
        visibility: data.dec(_f$visibility),
        solarradiation: data.dec(_f$solarradiation),
        solarenergy: data.dec(_f$solarenergy),
        uvindex: data.dec(_f$uvindex),
        severerisk: data.dec(_f$severerisk),
        sunriseEpoch: data.dec(_f$sunriseEpoch),
        sunsetEpoch: data.dec(_f$sunsetEpoch),
        moonphase: data.dec(_f$moonphase),
        description: data.dec(_f$description),
        icon: data.dec(_f$icon),
        source: data.dec(_f$source),
        hours: data.dec(_f$hours));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyData>(map);
  }

  static DailyData fromJson(String json) {
    return ensureInitialized().decodeJson<DailyData>(json);
  }
}

mixin DailyDataMappable {
  String toJson() {
    return DailyDataMapper.ensureInitialized()
        .encodeJson<DailyData>(this as DailyData);
  }

  Map<String, dynamic> toMap() {
    return DailyDataMapper.ensureInitialized()
        .encodeMap<DailyData>(this as DailyData);
  }

  DailyDataCopyWith<DailyData, DailyData, DailyData> get copyWith =>
      _DailyDataCopyWithImpl(this as DailyData, $identity, $identity);
  @override
  String toString() {
    return DailyDataMapper.ensureInitialized()
        .stringifyValue(this as DailyData);
  }

  @override
  bool operator ==(Object other) {
    return DailyDataMapper.ensureInitialized()
        .equalsValue(this as DailyData, other);
  }

  @override
  int get hashCode {
    return DailyDataMapper.ensureInitialized().hashValue(this as DailyData);
  }
}

extension DailyDataValueCopy<$R, $Out> on ObjectCopyWith<$R, DailyData, $Out> {
  DailyDataCopyWith<$R, DailyData, $Out> get $asDailyData =>
      $base.as((v, t, t2) => _DailyDataCopyWithImpl(v, t, t2));
}

abstract class DailyDataCopyWith<$R, $In extends DailyData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get preciptype;
  ListCopyWith<$R, HourlyData, HourlyDataCopyWith<$R, HourlyData, HourlyData>>?
      get hours;
  $R call(
      {int? datetimeEpoch,
      String? conditions,
      num? temp,
      num? feelslike,
      num? windspeed,
      num? tempmax,
      num? tempmin,
      double? feelslikemax,
      double? feelslikemin,
      double? dew,
      double? humidity,
      double? precip,
      double? precipprob,
      double? precipcover,
      List<dynamic>? preciptype,
      num? snow,
      num? snowdepth,
      double? windgust,
      double? winddir,
      double? pressure,
      double? cloudcover,
      double? visibility,
      double? solarradiation,
      double? solarenergy,
      num? uvindex,
      num? severerisk,
      num? sunriseEpoch,
      num? sunsetEpoch,
      double? moonphase,
      String? description,
      String? icon,
      String? source,
      List<HourlyData>? hours});
  DailyDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DailyDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyData, $Out>
    implements DailyDataCopyWith<$R, DailyData, $Out> {
  _DailyDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyData> $mapper =
      DailyDataMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get preciptype => $value.preciptype != null
          ? ListCopyWith(
              $value.preciptype!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(preciptype: v))
          : null;
  @override
  ListCopyWith<$R, HourlyData, HourlyDataCopyWith<$R, HourlyData, HourlyData>>?
      get hours => $value.hours != null
          ? ListCopyWith($value.hours!, (v, t) => v.copyWith.$chain(t),
              (v) => call(hours: v))
          : null;
  @override
  $R call(
          {int? datetimeEpoch,
          String? conditions,
          num? temp,
          num? feelslike,
          Object? windspeed = $none,
          Object? tempmax = $none,
          Object? tempmin = $none,
          Object? feelslikemax = $none,
          Object? feelslikemin = $none,
          Object? dew = $none,
          Object? humidity = $none,
          Object? precip = $none,
          Object? precipprob = $none,
          Object? precipcover = $none,
          Object? preciptype = $none,
          Object? snow = $none,
          Object? snowdepth = $none,
          Object? windgust = $none,
          Object? winddir = $none,
          Object? pressure = $none,
          Object? cloudcover = $none,
          Object? visibility = $none,
          Object? solarradiation = $none,
          Object? solarenergy = $none,
          Object? uvindex = $none,
          Object? severerisk = $none,
          Object? sunriseEpoch = $none,
          Object? sunsetEpoch = $none,
          Object? moonphase = $none,
          Object? description = $none,
          Object? icon = $none,
          Object? source = $none,
          Object? hours = $none}) =>
      $apply(FieldCopyWithData({
        if (datetimeEpoch != null) #datetimeEpoch: datetimeEpoch,
        if (conditions != null) #conditions: conditions,
        if (temp != null) #temp: temp,
        if (feelslike != null) #feelslike: feelslike,
        if (windspeed != $none) #windspeed: windspeed,
        if (tempmax != $none) #tempmax: tempmax,
        if (tempmin != $none) #tempmin: tempmin,
        if (feelslikemax != $none) #feelslikemax: feelslikemax,
        if (feelslikemin != $none) #feelslikemin: feelslikemin,
        if (dew != $none) #dew: dew,
        if (humidity != $none) #humidity: humidity,
        if (precip != $none) #precip: precip,
        if (precipprob != $none) #precipprob: precipprob,
        if (precipcover != $none) #precipcover: precipcover,
        if (preciptype != $none) #preciptype: preciptype,
        if (snow != $none) #snow: snow,
        if (snowdepth != $none) #snowdepth: snowdepth,
        if (windgust != $none) #windgust: windgust,
        if (winddir != $none) #winddir: winddir,
        if (pressure != $none) #pressure: pressure,
        if (cloudcover != $none) #cloudcover: cloudcover,
        if (visibility != $none) #visibility: visibility,
        if (solarradiation != $none) #solarradiation: solarradiation,
        if (solarenergy != $none) #solarenergy: solarenergy,
        if (uvindex != $none) #uvindex: uvindex,
        if (severerisk != $none) #severerisk: severerisk,
        if (sunriseEpoch != $none) #sunriseEpoch: sunriseEpoch,
        if (sunsetEpoch != $none) #sunsetEpoch: sunsetEpoch,
        if (moonphase != $none) #moonphase: moonphase,
        if (description != $none) #description: description,
        if (icon != $none) #icon: icon,
        if (source != $none) #source: source,
        if (hours != $none) #hours: hours
      }));
  @override
  DailyData $make(CopyWithData data) => DailyData(
      datetimeEpoch: data.get(#datetimeEpoch, or: $value.datetimeEpoch),
      conditions: data.get(#conditions, or: $value.conditions),
      temp: data.get(#temp, or: $value.temp),
      feelslike: data.get(#feelslike, or: $value.feelslike),
      windspeed: data.get(#windspeed, or: $value.windspeed),
      tempmax: data.get(#tempmax, or: $value.tempmax),
      tempmin: data.get(#tempmin, or: $value.tempmin),
      feelslikemax: data.get(#feelslikemax, or: $value.feelslikemax),
      feelslikemin: data.get(#feelslikemin, or: $value.feelslikemin),
      dew: data.get(#dew, or: $value.dew),
      humidity: data.get(#humidity, or: $value.humidity),
      precip: data.get(#precip, or: $value.precip),
      precipprob: data.get(#precipprob, or: $value.precipprob),
      precipcover: data.get(#precipcover, or: $value.precipcover),
      preciptype: data.get(#preciptype, or: $value.preciptype),
      snow: data.get(#snow, or: $value.snow),
      snowdepth: data.get(#snowdepth, or: $value.snowdepth),
      windgust: data.get(#windgust, or: $value.windgust),
      winddir: data.get(#winddir, or: $value.winddir),
      pressure: data.get(#pressure, or: $value.pressure),
      cloudcover: data.get(#cloudcover, or: $value.cloudcover),
      visibility: data.get(#visibility, or: $value.visibility),
      solarradiation: data.get(#solarradiation, or: $value.solarradiation),
      solarenergy: data.get(#solarenergy, or: $value.solarenergy),
      uvindex: data.get(#uvindex, or: $value.uvindex),
      severerisk: data.get(#severerisk, or: $value.severerisk),
      sunriseEpoch: data.get(#sunriseEpoch, or: $value.sunriseEpoch),
      sunsetEpoch: data.get(#sunsetEpoch, or: $value.sunsetEpoch),
      moonphase: data.get(#moonphase, or: $value.moonphase),
      description: data.get(#description, or: $value.description),
      icon: data.get(#icon, or: $value.icon),
      source: data.get(#source, or: $value.source),
      hours: data.get(#hours, or: $value.hours));

  @override
  DailyDataCopyWith<$R2, DailyData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DailyDataCopyWithImpl($value, $cast, t);
}
