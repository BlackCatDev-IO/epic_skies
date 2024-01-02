// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'current_data.dart';

class CurrentDataMapper extends ClassMapperBase<CurrentData> {
  CurrentDataMapper._();

  static CurrentDataMapper? _instance;
  static CurrentDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrentDataMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'CurrentData';

  static int _$datetimeEpoch(CurrentData v) => v.datetimeEpoch;
  static const Field<CurrentData, int> _f$datetimeEpoch =
      Field('datetimeEpoch', _$datetimeEpoch);
  static String _$conditions(CurrentData v) => v.conditions;
  static const Field<CurrentData, String> _f$conditions =
      Field('conditions', _$conditions);
  static num _$temp(CurrentData v) => v.temp;
  static const Field<CurrentData, num> _f$temp = Field('temp', _$temp);
  static num _$feelslike(CurrentData v) => v.feelslike;
  static const Field<CurrentData, num> _f$feelslike =
      Field('feelslike', _$feelslike);
  static num? _$windspeed(CurrentData v) => v.windspeed;
  static const Field<CurrentData, num> _f$windspeed =
      Field('windspeed', _$windspeed, opt: true);
  static double? _$humidity(CurrentData v) => v.humidity;
  static const Field<CurrentData, double> _f$humidity =
      Field('humidity', _$humidity, opt: true);
  static double? _$dew(CurrentData v) => v.dew;
  static const Field<CurrentData, double> _f$dew =
      Field('dew', _$dew, opt: true);
  static num? _$precip(CurrentData v) => v.precip;
  static const Field<CurrentData, num> _f$precip =
      Field('precip', _$precip, opt: true);
  static num? _$precipprob(CurrentData v) => v.precipprob;
  static const Field<CurrentData, num> _f$precipprob =
      Field('precipprob', _$precipprob, opt: true);
  static num? _$snow(CurrentData v) => v.snow;
  static const Field<CurrentData, num> _f$snow =
      Field('snow', _$snow, opt: true);
  static num? _$snowdepth(CurrentData v) => v.snowdepth;
  static const Field<CurrentData, num> _f$snowdepth =
      Field('snowdepth', _$snowdepth, opt: true);
  static List<dynamic>? _$preciptype(CurrentData v) => v.preciptype;
  static const Field<CurrentData, List<dynamic>> _f$preciptype =
      Field('preciptype', _$preciptype, opt: true);
  static num? _$windgust(CurrentData v) => v.windgust;
  static const Field<CurrentData, num> _f$windgust =
      Field('windgust', _$windgust, opt: true);
  static num? _$winddir(CurrentData v) => v.winddir;
  static const Field<CurrentData, num> _f$winddir =
      Field('winddir', _$winddir, opt: true);
  static num? _$pressure(CurrentData v) => v.pressure;
  static const Field<CurrentData, num> _f$pressure =
      Field('pressure', _$pressure, opt: true);
  static num? _$visibility(CurrentData v) => v.visibility;
  static const Field<CurrentData, num> _f$visibility =
      Field('visibility', _$visibility, opt: true);
  static num? _$cloudcover(CurrentData v) => v.cloudcover;
  static const Field<CurrentData, num> _f$cloudcover =
      Field('cloudcover', _$cloudcover, opt: true);
  static num? _$solarradiation(CurrentData v) => v.solarradiation;
  static const Field<CurrentData, num> _f$solarradiation =
      Field('solarradiation', _$solarradiation, opt: true);
  static double? _$solarenergy(CurrentData v) => v.solarenergy;
  static const Field<CurrentData, double> _f$solarenergy =
      Field('solarenergy', _$solarenergy, opt: true);
  static num? _$uvindex(CurrentData v) => v.uvindex;
  static const Field<CurrentData, num> _f$uvindex =
      Field('uvindex', _$uvindex, opt: true);
  static String? _$icon(CurrentData v) => v.icon;
  static const Field<CurrentData, String> _f$icon =
      Field('icon', _$icon, opt: true);
  static String? _$source(CurrentData v) => v.source;
  static const Field<CurrentData, String> _f$source =
      Field('source', _$source, opt: true);
  static String? _$sunrise(CurrentData v) => v.sunrise;
  static const Field<CurrentData, String> _f$sunrise =
      Field('sunrise', _$sunrise, opt: true);
  static num? _$sunriseEpoch(CurrentData v) => v.sunriseEpoch;
  static const Field<CurrentData, num> _f$sunriseEpoch =
      Field('sunriseEpoch', _$sunriseEpoch, opt: true);
  static String? _$sunset(CurrentData v) => v.sunset;
  static const Field<CurrentData, String> _f$sunset =
      Field('sunset', _$sunset, opt: true);
  static num? _$sunsetEpoch(CurrentData v) => v.sunsetEpoch;
  static const Field<CurrentData, num> _f$sunsetEpoch =
      Field('sunsetEpoch', _$sunsetEpoch, opt: true);
  static double? _$moonphase(CurrentData v) => v.moonphase;
  static const Field<CurrentData, double> _f$moonphase =
      Field('moonphase', _$moonphase, opt: true);

  @override
  final Map<Symbol, Field<CurrentData, dynamic>> fields = const {
    #datetimeEpoch: _f$datetimeEpoch,
    #conditions: _f$conditions,
    #temp: _f$temp,
    #feelslike: _f$feelslike,
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
    #icon: _f$icon,
    #source: _f$source,
    #sunrise: _f$sunrise,
    #sunriseEpoch: _f$sunriseEpoch,
    #sunset: _f$sunset,
    #sunsetEpoch: _f$sunsetEpoch,
    #moonphase: _f$moonphase,
  };

  static CurrentData _instantiate(DecodingData data) {
    return CurrentData(
        datetimeEpoch: data.dec(_f$datetimeEpoch),
        conditions: data.dec(_f$conditions),
        temp: data.dec(_f$temp),
        feelslike: data.dec(_f$feelslike),
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
        icon: data.dec(_f$icon),
        source: data.dec(_f$source),
        sunrise: data.dec(_f$sunrise),
        sunriseEpoch: data.dec(_f$sunriseEpoch),
        sunset: data.dec(_f$sunset),
        sunsetEpoch: data.dec(_f$sunsetEpoch),
        moonphase: data.dec(_f$moonphase));
  }

  @override
  final Function instantiate = _instantiate;

  static CurrentData fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<CurrentData>(map));
  }

  static CurrentData fromJson(String json) {
    return _guard((c) => c.fromJson<CurrentData>(json));
  }
}

mixin CurrentDataMappable {
  String toJson() {
    return CurrentDataMapper._guard((c) => c.toJson(this as CurrentData));
  }

  Map<String, dynamic> toMap() {
    return CurrentDataMapper._guard((c) => c.toMap(this as CurrentData));
  }

  CurrentDataCopyWith<CurrentData, CurrentData, CurrentData> get copyWith =>
      _CurrentDataCopyWithImpl(this as CurrentData, $identity, $identity);
  @override
  String toString() {
    return CurrentDataMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            CurrentDataMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return CurrentDataMapper._guard((c) => c.hash(this));
  }
}

extension CurrentDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CurrentData, $Out> {
  CurrentDataCopyWith<$R, CurrentData, $Out> get $asCurrentData =>
      $base.as((v, t, t2) => _CurrentDataCopyWithImpl(v, t, t2));
}

abstract class CurrentDataCopyWith<$R, $In extends CurrentData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
      get preciptype;
  $R call(
      {int? datetimeEpoch,
      String? conditions,
      num? temp,
      num? feelslike,
      num? windspeed,
      double? humidity,
      double? dew,
      num? precip,
      num? precipprob,
      num? snow,
      num? snowdepth,
      List<dynamic>? preciptype,
      num? windgust,
      num? winddir,
      num? pressure,
      num? visibility,
      num? cloudcover,
      num? solarradiation,
      double? solarenergy,
      num? uvindex,
      String? icon,
      String? source,
      String? sunrise,
      num? sunriseEpoch,
      String? sunset,
      num? sunsetEpoch,
      double? moonphase});
  CurrentDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CurrentDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CurrentData, $Out>
    implements CurrentDataCopyWith<$R, CurrentData, $Out> {
  _CurrentDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CurrentData> $mapper =
      CurrentDataMapper.ensureInitialized();
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
          String? conditions,
          num? temp,
          num? feelslike,
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
          Object? icon = $none,
          Object? source = $none,
          Object? sunrise = $none,
          Object? sunriseEpoch = $none,
          Object? sunset = $none,
          Object? sunsetEpoch = $none,
          Object? moonphase = $none}) =>
      $apply(FieldCopyWithData({
        if (datetimeEpoch != null) #datetimeEpoch: datetimeEpoch,
        if (conditions != null) #conditions: conditions,
        if (temp != null) #temp: temp,
        if (feelslike != null) #feelslike: feelslike,
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
        if (icon != $none) #icon: icon,
        if (source != $none) #source: source,
        if (sunrise != $none) #sunrise: sunrise,
        if (sunriseEpoch != $none) #sunriseEpoch: sunriseEpoch,
        if (sunset != $none) #sunset: sunset,
        if (sunsetEpoch != $none) #sunsetEpoch: sunsetEpoch,
        if (moonphase != $none) #moonphase: moonphase
      }));
  @override
  CurrentData $make(CopyWithData data) => CurrentData(
      datetimeEpoch: data.get(#datetimeEpoch, or: $value.datetimeEpoch),
      conditions: data.get(#conditions, or: $value.conditions),
      temp: data.get(#temp, or: $value.temp),
      feelslike: data.get(#feelslike, or: $value.feelslike),
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
      icon: data.get(#icon, or: $value.icon),
      source: data.get(#source, or: $value.source),
      sunrise: data.get(#sunrise, or: $value.sunrise),
      sunriseEpoch: data.get(#sunriseEpoch, or: $value.sunriseEpoch),
      sunset: data.get(#sunset, or: $value.sunset),
      sunsetEpoch: data.get(#sunsetEpoch, or: $value.sunsetEpoch),
      moonphase: data.get(#moonphase, or: $value.moonphase));

  @override
  CurrentDataCopyWith<$R2, CurrentData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CurrentDataCopyWithImpl($value, $cast, t);
}
