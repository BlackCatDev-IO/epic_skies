// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_alert_summary.dart';

class WeatherAlertSummaryMapper extends ClassMapperBase<WeatherAlertSummary> {
  WeatherAlertSummaryMapper._();

  static WeatherAlertSummaryMapper? _instance;
  static WeatherAlertSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherAlertSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherAlertSummary';

  static String _$id(WeatherAlertSummary v) => v.id;
  static const Field<WeatherAlertSummary, String> _f$id = Field('id', _$id);
  static String _$certainty(WeatherAlertSummary v) => v.certainty;
  static const Field<WeatherAlertSummary, String> _f$certainty =
      Field('certainty', _$certainty);
  static String _$countryCode(WeatherAlertSummary v) => v.countryCode;
  static const Field<WeatherAlertSummary, String> _f$countryCode =
      Field('countryCode', _$countryCode);
  static String _$description(WeatherAlertSummary v) => v.description;
  static const Field<WeatherAlertSummary, String> _f$description =
      Field('description', _$description);
  static DateTime _$effectiveTime(WeatherAlertSummary v) => v.effectiveTime;
  static const Field<WeatherAlertSummary, DateTime> _f$effectiveTime =
      Field('effectiveTime', _$effectiveTime);
  static DateTime _$expireTime(WeatherAlertSummary v) => v.expireTime;
  static const Field<WeatherAlertSummary, DateTime> _f$expireTime =
      Field('expireTime', _$expireTime);
  static DateTime _$issuedTime(WeatherAlertSummary v) => v.issuedTime;
  static const Field<WeatherAlertSummary, DateTime> _f$issuedTime =
      Field('issuedTime', _$issuedTime);
  static List<String> _$responses(WeatherAlertSummary v) => v.responses;
  static const Field<WeatherAlertSummary, List<String>> _f$responses =
      Field('responses', _$responses);
  static String _$severity(WeatherAlertSummary v) => v.severity;
  static const Field<WeatherAlertSummary, String> _f$severity =
      Field('severity', _$severity);
  static String _$source(WeatherAlertSummary v) => v.source;
  static const Field<WeatherAlertSummary, String> _f$source =
      Field('source', _$source);
  static String? _$areaId(WeatherAlertSummary v) => v.areaId;
  static const Field<WeatherAlertSummary, String> _f$areaId =
      Field('areaId', _$areaId, opt: true);
  static String? _$areaName(WeatherAlertSummary v) => v.areaName;
  static const Field<WeatherAlertSummary, String> _f$areaName =
      Field('areaName', _$areaName, opt: true);
  static String? _$detailsUrl(WeatherAlertSummary v) => v.detailsUrl;
  static const Field<WeatherAlertSummary, String> _f$detailsUrl =
      Field('detailsUrl', _$detailsUrl, opt: true);
  static DateTime? _$eventEndTime(WeatherAlertSummary v) => v.eventEndTime;
  static const Field<WeatherAlertSummary, DateTime> _f$eventEndTime =
      Field('eventEndTime', _$eventEndTime, opt: true);
  static DateTime? _$eventOnsetTime(WeatherAlertSummary v) => v.eventOnsetTime;
  static const Field<WeatherAlertSummary, DateTime> _f$eventOnsetTime =
      Field('eventOnsetTime', _$eventOnsetTime, opt: true);
  static String? _$urgency(WeatherAlertSummary v) => v.urgency;
  static const Field<WeatherAlertSummary, String> _f$urgency =
      Field('urgency', _$urgency, opt: true);

  @override
  final MappableFields<WeatherAlertSummary> fields = const {
    #id: _f$id,
    #certainty: _f$certainty,
    #countryCode: _f$countryCode,
    #description: _f$description,
    #effectiveTime: _f$effectiveTime,
    #expireTime: _f$expireTime,
    #issuedTime: _f$issuedTime,
    #responses: _f$responses,
    #severity: _f$severity,
    #source: _f$source,
    #areaId: _f$areaId,
    #areaName: _f$areaName,
    #detailsUrl: _f$detailsUrl,
    #eventEndTime: _f$eventEndTime,
    #eventOnsetTime: _f$eventOnsetTime,
    #urgency: _f$urgency,
  };

  static WeatherAlertSummary _instantiate(DecodingData data) {
    return WeatherAlertSummary(
        id: data.dec(_f$id),
        certainty: data.dec(_f$certainty),
        countryCode: data.dec(_f$countryCode),
        description: data.dec(_f$description),
        effectiveTime: data.dec(_f$effectiveTime),
        expireTime: data.dec(_f$expireTime),
        issuedTime: data.dec(_f$issuedTime),
        responses: data.dec(_f$responses),
        severity: data.dec(_f$severity),
        source: data.dec(_f$source),
        areaId: data.dec(_f$areaId),
        areaName: data.dec(_f$areaName),
        detailsUrl: data.dec(_f$detailsUrl),
        eventEndTime: data.dec(_f$eventEndTime),
        eventOnsetTime: data.dec(_f$eventOnsetTime),
        urgency: data.dec(_f$urgency));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherAlertSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherAlertSummary>(map);
  }

  static WeatherAlertSummary fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherAlertSummary>(json);
  }
}

mixin WeatherAlertSummaryMappable {
  String toJson() {
    return WeatherAlertSummaryMapper.ensureInitialized()
        .encodeJson<WeatherAlertSummary>(this as WeatherAlertSummary);
  }

  Map<String, dynamic> toMap() {
    return WeatherAlertSummaryMapper.ensureInitialized()
        .encodeMap<WeatherAlertSummary>(this as WeatherAlertSummary);
  }

  WeatherAlertSummaryCopyWith<WeatherAlertSummary, WeatherAlertSummary,
          WeatherAlertSummary>
      get copyWith => _WeatherAlertSummaryCopyWithImpl(
          this as WeatherAlertSummary, $identity, $identity);
  @override
  String toString() {
    return WeatherAlertSummaryMapper.ensureInitialized()
        .stringifyValue(this as WeatherAlertSummary);
  }

  @override
  bool operator ==(Object other) {
    return WeatherAlertSummaryMapper.ensureInitialized()
        .equalsValue(this as WeatherAlertSummary, other);
  }

  @override
  int get hashCode {
    return WeatherAlertSummaryMapper.ensureInitialized()
        .hashValue(this as WeatherAlertSummary);
  }
}

extension WeatherAlertSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherAlertSummary, $Out> {
  WeatherAlertSummaryCopyWith<$R, WeatherAlertSummary, $Out>
      get $asWeatherAlertSummary =>
          $base.as((v, t, t2) => _WeatherAlertSummaryCopyWithImpl(v, t, t2));
}

abstract class WeatherAlertSummaryCopyWith<$R, $In extends WeatherAlertSummary,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get responses;
  $R call(
      {String? id,
      String? certainty,
      String? countryCode,
      String? description,
      DateTime? effectiveTime,
      DateTime? expireTime,
      DateTime? issuedTime,
      List<String>? responses,
      String? severity,
      String? source,
      String? areaId,
      String? areaName,
      String? detailsUrl,
      DateTime? eventEndTime,
      DateTime? eventOnsetTime,
      String? urgency});
  WeatherAlertSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WeatherAlertSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherAlertSummary, $Out>
    implements WeatherAlertSummaryCopyWith<$R, WeatherAlertSummary, $Out> {
  _WeatherAlertSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherAlertSummary> $mapper =
      WeatherAlertSummaryMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get responses =>
      ListCopyWith($value.responses, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(responses: v));
  @override
  $R call(
          {String? id,
          String? certainty,
          String? countryCode,
          String? description,
          DateTime? effectiveTime,
          DateTime? expireTime,
          DateTime? issuedTime,
          List<String>? responses,
          String? severity,
          String? source,
          Object? areaId = $none,
          Object? areaName = $none,
          Object? detailsUrl = $none,
          Object? eventEndTime = $none,
          Object? eventOnsetTime = $none,
          Object? urgency = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (certainty != null) #certainty: certainty,
        if (countryCode != null) #countryCode: countryCode,
        if (description != null) #description: description,
        if (effectiveTime != null) #effectiveTime: effectiveTime,
        if (expireTime != null) #expireTime: expireTime,
        if (issuedTime != null) #issuedTime: issuedTime,
        if (responses != null) #responses: responses,
        if (severity != null) #severity: severity,
        if (source != null) #source: source,
        if (areaId != $none) #areaId: areaId,
        if (areaName != $none) #areaName: areaName,
        if (detailsUrl != $none) #detailsUrl: detailsUrl,
        if (eventEndTime != $none) #eventEndTime: eventEndTime,
        if (eventOnsetTime != $none) #eventOnsetTime: eventOnsetTime,
        if (urgency != $none) #urgency: urgency
      }));
  @override
  WeatherAlertSummary $make(CopyWithData data) => WeatherAlertSummary(
      id: data.get(#id, or: $value.id),
      certainty: data.get(#certainty, or: $value.certainty),
      countryCode: data.get(#countryCode, or: $value.countryCode),
      description: data.get(#description, or: $value.description),
      effectiveTime: data.get(#effectiveTime, or: $value.effectiveTime),
      expireTime: data.get(#expireTime, or: $value.expireTime),
      issuedTime: data.get(#issuedTime, or: $value.issuedTime),
      responses: data.get(#responses, or: $value.responses),
      severity: data.get(#severity, or: $value.severity),
      source: data.get(#source, or: $value.source),
      areaId: data.get(#areaId, or: $value.areaId),
      areaName: data.get(#areaName, or: $value.areaName),
      detailsUrl: data.get(#detailsUrl, or: $value.detailsUrl),
      eventEndTime: data.get(#eventEndTime, or: $value.eventEndTime),
      eventOnsetTime: data.get(#eventOnsetTime, or: $value.eventOnsetTime),
      urgency: data.get(#urgency, or: $value.urgency));

  @override
  WeatherAlertSummaryCopyWith<$R2, WeatherAlertSummary, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _WeatherAlertSummaryCopyWithImpl($value, $cast, t);
}
