// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'weather.dart';

class WeatherMapper extends ClassMapperBase<Weather> {
  WeatherMapper._();

  static WeatherMapper? _instance;
  static WeatherMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherMapper._());
      CurrentWeatherDataMapper.ensureInitialized();
      ForecastDailyMapper.ensureInitialized();
      ForecastHourlyMapper.ensureInitialized();
      NextHourForecastMapper.ensureInitialized();
      WeatherAlertCollectionMapper.ensureInitialized();
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Weather';

  static CurrentWeatherData _$currentWeather(Weather v) => v.currentWeather;
  static const Field<Weather, CurrentWeatherData> _f$currentWeather =
      Field('currentWeather', _$currentWeather);
  static ForecastDaily _$forecastDaily(Weather v) => v.forecastDaily;
  static const Field<Weather, ForecastDaily> _f$forecastDaily =
      Field('forecastDaily', _$forecastDaily);
  static ForecastHourly _$forecastHourly(Weather v) => v.forecastHourly;
  static const Field<Weather, ForecastHourly> _f$forecastHourly =
      Field('forecastHourly', _$forecastHourly);
  static NextHourForecast? _$forecastNextHour(Weather v) => v.forecastNextHour;
  static const Field<Weather, NextHourForecast> _f$forecastNextHour =
      Field('forecastNextHour', _$forecastNextHour, opt: true);
  static WeatherAlertCollection? _$weatherAlerts(Weather v) => v.weatherAlerts;
  static const Field<Weather, WeatherAlertCollection> _f$weatherAlerts =
      Field('weatherAlerts', _$weatherAlerts, opt: true);

  @override
  final Map<Symbol, Field<Weather, dynamic>> fields = const {
    #currentWeather: _f$currentWeather,
    #forecastDaily: _f$forecastDaily,
    #forecastHourly: _f$forecastHourly,
    #forecastNextHour: _f$forecastNextHour,
    #weatherAlerts: _f$weatherAlerts,
  };

  static Weather _instantiate(DecodingData data) {
    return Weather(
        currentWeather: data.dec(_f$currentWeather),
        forecastDaily: data.dec(_f$forecastDaily),
        forecastHourly: data.dec(_f$forecastHourly),
        forecastNextHour: data.dec(_f$forecastNextHour),
        weatherAlerts: data.dec(_f$weatherAlerts));
  }

  @override
  final Function instantiate = _instantiate;

  static Weather fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Weather>(map));
  }

  static Weather fromJson(String json) {
    return _guard((c) => c.fromJson<Weather>(json));
  }
}

mixin WeatherMappable {
  String toJson() {
    return WeatherMapper._guard((c) => c.toJson(this as Weather));
  }

  Map<String, dynamic> toMap() {
    return WeatherMapper._guard((c) => c.toMap(this as Weather));
  }

  WeatherCopyWith<Weather, Weather, Weather> get copyWith =>
      _WeatherCopyWithImpl(this as Weather, $identity, $identity);
  @override
  String toString() {
    return WeatherMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return WeatherMapper._guard((c) => c.hash(this));
  }
}

extension WeatherValueCopy<$R, $Out> on ObjectCopyWith<$R, Weather, $Out> {
  WeatherCopyWith<$R, Weather, $Out> get $asWeather =>
      $base.as((v, t, t2) => _WeatherCopyWithImpl(v, t, t2));
}

abstract class WeatherCopyWith<$R, $In extends Weather, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  CurrentWeatherDataCopyWith<$R, CurrentWeatherData, CurrentWeatherData>
      get currentWeather;
  ForecastDailyCopyWith<$R, ForecastDaily, ForecastDaily> get forecastDaily;
  ForecastHourlyCopyWith<$R, ForecastHourly, ForecastHourly> get forecastHourly;
  NextHourForecastCopyWith<$R, NextHourForecast, NextHourForecast>?
      get forecastNextHour;
  WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection,
      WeatherAlertCollection>? get weatherAlerts;
  $R call(
      {CurrentWeatherData? currentWeather,
      ForecastDaily? forecastDaily,
      ForecastHourly? forecastHourly,
      NextHourForecast? forecastNextHour,
      WeatherAlertCollection? weatherAlerts});
  WeatherCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Weather, $Out>
    implements WeatherCopyWith<$R, Weather, $Out> {
  _WeatherCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Weather> $mapper =
      WeatherMapper.ensureInitialized();
  @override
  CurrentWeatherDataCopyWith<$R, CurrentWeatherData, CurrentWeatherData>
      get currentWeather =>
          $value.currentWeather.copyWith.$chain((v) => call(currentWeather: v));
  @override
  ForecastDailyCopyWith<$R, ForecastDaily, ForecastDaily> get forecastDaily =>
      $value.forecastDaily.copyWith.$chain((v) => call(forecastDaily: v));
  @override
  ForecastHourlyCopyWith<$R, ForecastHourly, ForecastHourly>
      get forecastHourly =>
          $value.forecastHourly.copyWith.$chain((v) => call(forecastHourly: v));
  @override
  NextHourForecastCopyWith<$R, NextHourForecast, NextHourForecast>?
      get forecastNextHour => $value.forecastNextHour?.copyWith
          .$chain((v) => call(forecastNextHour: v));
  @override
  WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection,
          WeatherAlertCollection>?
      get weatherAlerts =>
          $value.weatherAlerts?.copyWith.$chain((v) => call(weatherAlerts: v));
  @override
  $R call(
          {CurrentWeatherData? currentWeather,
          ForecastDaily? forecastDaily,
          ForecastHourly? forecastHourly,
          Object? forecastNextHour = $none,
          Object? weatherAlerts = $none}) =>
      $apply(FieldCopyWithData({
        if (currentWeather != null) #currentWeather: currentWeather,
        if (forecastDaily != null) #forecastDaily: forecastDaily,
        if (forecastHourly != null) #forecastHourly: forecastHourly,
        if (forecastNextHour != $none) #forecastNextHour: forecastNextHour,
        if (weatherAlerts != $none) #weatherAlerts: weatherAlerts
      }));
  @override
  Weather $make(CopyWithData data) => Weather(
      currentWeather: data.get(#currentWeather, or: $value.currentWeather),
      forecastDaily: data.get(#forecastDaily, or: $value.forecastDaily),
      forecastHourly: data.get(#forecastHourly, or: $value.forecastHourly),
      forecastNextHour:
          data.get(#forecastNextHour, or: $value.forecastNextHour),
      weatherAlerts: data.get(#weatherAlerts, or: $value.weatherAlerts));

  @override
  WeatherCopyWith<$R2, Weather, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _WeatherCopyWithImpl($value, $cast, t);
}
