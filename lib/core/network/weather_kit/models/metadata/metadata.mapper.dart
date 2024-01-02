// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'metadata.dart';

class MetaDataMapper extends ClassMapperBase<MetaData> {
  MetaDataMapper._();

  static MetaDataMapper? _instance;
  static MetaDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MetaDataMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'MetaData';

  static String? _$attributionURL(MetaData v) => v.attributionURL;
  static const Field<MetaData, String> _f$attributionURL =
      Field('attributionURL', _$attributionURL);
  static DateTime _$expireTime(MetaData v) => v.expireTime;
  static const Field<MetaData, DateTime> _f$expireTime =
      Field('expireTime', _$expireTime);
  static String? _$language(MetaData v) => v.language;
  static const Field<MetaData, String> _f$language =
      Field('language', _$language);
  static double _$latitude(MetaData v) => v.latitude;
  static const Field<MetaData, double> _f$latitude =
      Field('latitude', _$latitude);
  static double _$longitude(MetaData v) => v.longitude;
  static const Field<MetaData, double> _f$longitude =
      Field('longitude', _$longitude);
  static String? _$providerLogo(MetaData v) => v.providerLogo;
  static const Field<MetaData, String> _f$providerLogo =
      Field('providerLogo', _$providerLogo);
  static String? _$providerName(MetaData v) => v.providerName;
  static const Field<MetaData, String> _f$providerName =
      Field('providerName', _$providerName);
  static DateTime _$readTime(MetaData v) => v.readTime;
  static const Field<MetaData, DateTime> _f$readTime =
      Field('readTime', _$readTime);
  static DateTime? _$reportedTime(MetaData v) => v.reportedTime;
  static const Field<MetaData, DateTime> _f$reportedTime =
      Field('reportedTime', _$reportedTime);
  static bool? _$temporarilyUnavailable(MetaData v) => v.temporarilyUnavailable;
  static const Field<MetaData, bool> _f$temporarilyUnavailable =
      Field('temporarilyUnavailable', _$temporarilyUnavailable);
  static String? _$units(MetaData v) => v.units;
  static const Field<MetaData, String> _f$units = Field('units', _$units);
  static int _$version(MetaData v) => v.version;
  static const Field<MetaData, int> _f$version = Field('version', _$version);

  @override
  final Map<Symbol, Field<MetaData, dynamic>> fields = const {
    #attributionURL: _f$attributionURL,
    #expireTime: _f$expireTime,
    #language: _f$language,
    #latitude: _f$latitude,
    #longitude: _f$longitude,
    #providerLogo: _f$providerLogo,
    #providerName: _f$providerName,
    #readTime: _f$readTime,
    #reportedTime: _f$reportedTime,
    #temporarilyUnavailable: _f$temporarilyUnavailable,
    #units: _f$units,
    #version: _f$version,
  };

  static MetaData _instantiate(DecodingData data) {
    return MetaData(
        attributionURL: data.dec(_f$attributionURL),
        expireTime: data.dec(_f$expireTime),
        language: data.dec(_f$language),
        latitude: data.dec(_f$latitude),
        longitude: data.dec(_f$longitude),
        providerLogo: data.dec(_f$providerLogo),
        providerName: data.dec(_f$providerName),
        readTime: data.dec(_f$readTime),
        reportedTime: data.dec(_f$reportedTime),
        temporarilyUnavailable: data.dec(_f$temporarilyUnavailable),
        units: data.dec(_f$units),
        version: data.dec(_f$version));
  }

  @override
  final Function instantiate = _instantiate;

  static MetaData fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<MetaData>(map));
  }

  static MetaData fromJson(String json) {
    return _guard((c) => c.fromJson<MetaData>(json));
  }
}

mixin MetaDataMappable {
  String toJson() {
    return MetaDataMapper._guard((c) => c.toJson(this as MetaData));
  }

  Map<String, dynamic> toMap() {
    return MetaDataMapper._guard((c) => c.toMap(this as MetaData));
  }

  MetaDataCopyWith<MetaData, MetaData, MetaData> get copyWith =>
      _MetaDataCopyWithImpl(this as MetaData, $identity, $identity);
  @override
  String toString() {
    return MetaDataMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            MetaDataMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return MetaDataMapper._guard((c) => c.hash(this));
  }
}

extension MetaDataValueCopy<$R, $Out> on ObjectCopyWith<$R, MetaData, $Out> {
  MetaDataCopyWith<$R, MetaData, $Out> get $asMetaData =>
      $base.as((v, t, t2) => _MetaDataCopyWithImpl(v, t, t2));
}

abstract class MetaDataCopyWith<$R, $In extends MetaData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? attributionURL,
      DateTime? expireTime,
      String? language,
      double? latitude,
      double? longitude,
      String? providerLogo,
      String? providerName,
      DateTime? readTime,
      DateTime? reportedTime,
      bool? temporarilyUnavailable,
      String? units,
      int? version});
  MetaDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MetaDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MetaData, $Out>
    implements MetaDataCopyWith<$R, MetaData, $Out> {
  _MetaDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MetaData> $mapper =
      MetaDataMapper.ensureInitialized();
  @override
  $R call(
          {Object? attributionURL = $none,
          DateTime? expireTime,
          Object? language = $none,
          double? latitude,
          double? longitude,
          Object? providerLogo = $none,
          Object? providerName = $none,
          DateTime? readTime,
          Object? reportedTime = $none,
          Object? temporarilyUnavailable = $none,
          Object? units = $none,
          int? version}) =>
      $apply(FieldCopyWithData({
        if (attributionURL != $none) #attributionURL: attributionURL,
        if (expireTime != null) #expireTime: expireTime,
        if (language != $none) #language: language,
        if (latitude != null) #latitude: latitude,
        if (longitude != null) #longitude: longitude,
        if (providerLogo != $none) #providerLogo: providerLogo,
        if (providerName != $none) #providerName: providerName,
        if (readTime != null) #readTime: readTime,
        if (reportedTime != $none) #reportedTime: reportedTime,
        if (temporarilyUnavailable != $none)
          #temporarilyUnavailable: temporarilyUnavailable,
        if (units != $none) #units: units,
        if (version != null) #version: version
      }));
  @override
  MetaData $make(CopyWithData data) => MetaData(
      attributionURL: data.get(#attributionURL, or: $value.attributionURL),
      expireTime: data.get(#expireTime, or: $value.expireTime),
      language: data.get(#language, or: $value.language),
      latitude: data.get(#latitude, or: $value.latitude),
      longitude: data.get(#longitude, or: $value.longitude),
      providerLogo: data.get(#providerLogo, or: $value.providerLogo),
      providerName: data.get(#providerName, or: $value.providerName),
      readTime: data.get(#readTime, or: $value.readTime),
      reportedTime: data.get(#reportedTime, or: $value.reportedTime),
      temporarilyUnavailable:
          data.get(#temporarilyUnavailable, or: $value.temporarilyUnavailable),
      units: data.get(#units, or: $value.units),
      version: data.get(#version, or: $value.version));

  @override
  MetaDataCopyWith<$R2, MetaData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MetaDataCopyWithImpl($value, $cast, t);
}
