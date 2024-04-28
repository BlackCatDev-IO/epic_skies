// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_alert_collection.dart';

class WeatherAlertCollectionMapper
    extends ClassMapperBase<WeatherAlertCollection> {
  WeatherAlertCollectionMapper._();

  static WeatherAlertCollectionMapper? _instance;
  static WeatherAlertCollectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherAlertCollectionMapper._());
      WeatherAlertSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherAlertCollection';

  static List<WeatherAlertSummary> _$alerts(WeatherAlertCollection v) =>
      v.alerts;
  static const Field<WeatherAlertCollection, List<WeatherAlertSummary>>
      _f$alerts = Field('alerts', _$alerts, opt: true, def: const []);
  static String? _$detailsUrl(WeatherAlertCollection v) => v.detailsUrl;
  static const Field<WeatherAlertCollection, String> _f$detailsUrl =
      Field('detailsUrl', _$detailsUrl, opt: true, def: '');

  @override
  final MappableFields<WeatherAlertCollection> fields = const {
    #alerts: _f$alerts,
    #detailsUrl: _f$detailsUrl,
  };

  static WeatherAlertCollection _instantiate(DecodingData data) {
    return WeatherAlertCollection(
        alerts: data.dec(_f$alerts), detailsUrl: data.dec(_f$detailsUrl));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherAlertCollection fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherAlertCollection>(map);
  }

  static WeatherAlertCollection fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherAlertCollection>(json);
  }
}

mixin WeatherAlertCollectionMappable {
  String toJson() {
    return WeatherAlertCollectionMapper.ensureInitialized()
        .encodeJson<WeatherAlertCollection>(this as WeatherAlertCollection);
  }

  Map<String, dynamic> toMap() {
    return WeatherAlertCollectionMapper.ensureInitialized()
        .encodeMap<WeatherAlertCollection>(this as WeatherAlertCollection);
  }

  WeatherAlertCollectionCopyWith<WeatherAlertCollection, WeatherAlertCollection,
          WeatherAlertCollection>
      get copyWith => _WeatherAlertCollectionCopyWithImpl(
          this as WeatherAlertCollection, $identity, $identity);
  @override
  String toString() {
    return WeatherAlertCollectionMapper.ensureInitialized()
        .stringifyValue(this as WeatherAlertCollection);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherAlertCollectionMapper.ensureInitialized()
                .isValueEqual(this as WeatherAlertCollection, other));
  }

  @override
  int get hashCode {
    return WeatherAlertCollectionMapper.ensureInitialized()
        .hashValue(this as WeatherAlertCollection);
  }
}

extension WeatherAlertCollectionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherAlertCollection, $Out> {
  WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection, $Out>
      get $asWeatherAlertCollection =>
          $base.as((v, t, t2) => _WeatherAlertCollectionCopyWithImpl(v, t, t2));
}

abstract class WeatherAlertCollectionCopyWith<
    $R,
    $In extends WeatherAlertCollection,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
      $R,
      WeatherAlertSummary,
      WeatherAlertSummaryCopyWith<$R, WeatherAlertSummary,
          WeatherAlertSummary>> get alerts;
  $R call({List<WeatherAlertSummary>? alerts, String? detailsUrl});
  WeatherAlertCollectionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WeatherAlertCollectionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherAlertCollection, $Out>
    implements
        WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection, $Out> {
  _WeatherAlertCollectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherAlertCollection> $mapper =
      WeatherAlertCollectionMapper.ensureInitialized();
  @override
  ListCopyWith<
      $R,
      WeatherAlertSummary,
      WeatherAlertSummaryCopyWith<$R, WeatherAlertSummary,
          WeatherAlertSummary>> get alerts => ListCopyWith(
      $value.alerts, (v, t) => v.copyWith.$chain(t), (v) => call(alerts: v));
  @override
  $R call({List<WeatherAlertSummary>? alerts, Object? detailsUrl = $none}) =>
      $apply(FieldCopyWithData({
        if (alerts != null) #alerts: alerts,
        if (detailsUrl != $none) #detailsUrl: detailsUrl
      }));
  @override
  WeatherAlertCollection $make(CopyWithData data) => WeatherAlertCollection(
      alerts: data.get(#alerts, or: $value.alerts),
      detailsUrl: data.get(#detailsUrl, or: $value.detailsUrl));

  @override
  WeatherAlertCollectionCopyWith<$R2, WeatherAlertCollection, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _WeatherAlertCollectionCopyWithImpl($value, $cast, t);
}
