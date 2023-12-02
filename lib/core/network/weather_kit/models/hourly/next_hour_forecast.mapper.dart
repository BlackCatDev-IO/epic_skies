// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'next_hour_forecast.dart';

class NextHourForecastMapper extends ClassMapperBase<NextHourForecast> {
  NextHourForecastMapper._();

  static NextHourForecastMapper? _instance;
  static NextHourForecastMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NextHourForecastMapper._());
      ForecastMinuteMapper.ensureInitialized();
      ForecastPeriodSummaryMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'NextHourForecast';

  static DateTime? _$forecastStart(NextHourForecast v) => v.forecastStart;
  static const Field<NextHourForecast, DateTime> _f$forecastStart =
      Field('forecastStart', _$forecastStart);
  static DateTime? _$forecastEnd(NextHourForecast v) => v.forecastEnd;
  static const Field<NextHourForecast, DateTime> _f$forecastEnd =
      Field('forecastEnd', _$forecastEnd);
  static List<ForecastMinute> _$minutes(NextHourForecast v) => v.minutes;
  static const Field<NextHourForecast, List<ForecastMinute>> _f$minutes =
      Field('minutes', _$minutes);
  static List<ForecastPeriodSummary> _$summary(NextHourForecast v) => v.summary;
  static const Field<NextHourForecast, List<ForecastPeriodSummary>> _f$summary =
      Field('summary', _$summary);

  @override
  final Map<Symbol, Field<NextHourForecast, dynamic>> fields = const {
    #forecastStart: _f$forecastStart,
    #forecastEnd: _f$forecastEnd,
    #minutes: _f$minutes,
    #summary: _f$summary,
  };

  static NextHourForecast _instantiate(DecodingData data) {
    return NextHourForecast(
        forecastStart: data.dec(_f$forecastStart),
        forecastEnd: data.dec(_f$forecastEnd),
        minutes: data.dec(_f$minutes),
        summary: data.dec(_f$summary));
  }

  @override
  final Function instantiate = _instantiate;

  static NextHourForecast fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<NextHourForecast>(map));
  }

  static NextHourForecast fromJson(String json) {
    return _guard((c) => c.fromJson<NextHourForecast>(json));
  }
}

mixin NextHourForecastMappable {
  String toJson() {
    return NextHourForecastMapper._guard(
        (c) => c.toJson(this as NextHourForecast));
  }

  Map<String, dynamic> toMap() {
    return NextHourForecastMapper._guard(
        (c) => c.toMap(this as NextHourForecast));
  }

  NextHourForecastCopyWith<NextHourForecast, NextHourForecast, NextHourForecast>
      get copyWith => _NextHourForecastCopyWithImpl(
          this as NextHourForecast, $identity, $identity);
  @override
  String toString() {
    return NextHourForecastMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            NextHourForecastMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return NextHourForecastMapper._guard((c) => c.hash(this));
  }
}

extension NextHourForecastValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NextHourForecast, $Out> {
  NextHourForecastCopyWith<$R, NextHourForecast, $Out>
      get $asNextHourForecast =>
          $base.as((v, t, t2) => _NextHourForecastCopyWithImpl(v, t, t2));
}

abstract class NextHourForecastCopyWith<$R, $In extends NextHourForecast, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ForecastMinute,
      ForecastMinuteCopyWith<$R, ForecastMinute, ForecastMinute>> get minutes;
  ListCopyWith<
      $R,
      ForecastPeriodSummary,
      ForecastPeriodSummaryCopyWith<$R, ForecastPeriodSummary,
          ForecastPeriodSummary>> get summary;
  $R call(
      {DateTime? forecastStart,
      DateTime? forecastEnd,
      List<ForecastMinute>? minutes,
      List<ForecastPeriodSummary>? summary});
  NextHourForecastCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _NextHourForecastCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NextHourForecast, $Out>
    implements NextHourForecastCopyWith<$R, NextHourForecast, $Out> {
  _NextHourForecastCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NextHourForecast> $mapper =
      NextHourForecastMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ForecastMinute,
          ForecastMinuteCopyWith<$R, ForecastMinute, ForecastMinute>>
      get minutes => ListCopyWith($value.minutes,
          (v, t) => v.copyWith.$chain(t), (v) => call(minutes: v));
  @override
  ListCopyWith<
      $R,
      ForecastPeriodSummary,
      ForecastPeriodSummaryCopyWith<$R, ForecastPeriodSummary,
          ForecastPeriodSummary>> get summary => ListCopyWith(
      $value.summary, (v, t) => v.copyWith.$chain(t), (v) => call(summary: v));
  @override
  $R call(
          {Object? forecastStart = $none,
          Object? forecastEnd = $none,
          List<ForecastMinute>? minutes,
          List<ForecastPeriodSummary>? summary}) =>
      $apply(FieldCopyWithData({
        if (forecastStart != $none) #forecastStart: forecastStart,
        if (forecastEnd != $none) #forecastEnd: forecastEnd,
        if (minutes != null) #minutes: minutes,
        if (summary != null) #summary: summary
      }));
  @override
  NextHourForecast $make(CopyWithData data) => NextHourForecast(
      forecastStart: data.get(#forecastStart, or: $value.forecastStart),
      forecastEnd: data.get(#forecastEnd, or: $value.forecastEnd),
      minutes: data.get(#minutes, or: $value.minutes),
      summary: data.get(#summary, or: $value.summary));

  @override
  NextHourForecastCopyWith<$R2, NextHourForecast, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NextHourForecastCopyWithImpl($value, $cast, t);
}
