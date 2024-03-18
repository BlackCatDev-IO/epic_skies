// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'weather_state.dart';

class WeatherStatusMapper extends EnumMapper<WeatherStatus> {
  WeatherStatusMapper._();

  static WeatherStatusMapper? _instance;
  static WeatherStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherStatusMapper._());
    }
    return _instance!;
  }

  static WeatherStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  WeatherStatus decode(dynamic value) {
    switch (value) {
      case 'initial':
        return WeatherStatus.initial;
      case 'loading':
        return WeatherStatus.loading;
      case 'success':
        return WeatherStatus.success;
      case 'unitSettingsUpdate':
        return WeatherStatus.unitSettingsUpdate;
      case 'error':
        return WeatherStatus.error;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(WeatherStatus self) {
    switch (self) {
      case WeatherStatus.initial:
        return 'initial';
      case WeatherStatus.loading:
        return 'loading';
      case WeatherStatus.success:
        return 'success';
      case WeatherStatus.unitSettingsUpdate:
        return 'unitSettingsUpdate';
      case WeatherStatus.error:
        return 'error';
    }
  }
}

extension WeatherStatusMapperExtension on WeatherStatus {
  String toValue() {
    WeatherStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<WeatherStatus>(this) as String;
  }
}

class WeatherStateMapper extends ClassMapperBase<WeatherState> {
  WeatherStateMapper._();

  static WeatherStateMapper? _instance;
  static WeatherStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WeatherStateMapper._());
      WeatherStatusMapper.ensureInitialized();
      WeatherResponseModelMapper.ensureInitialized();
      WeatherMapper.ensureInitialized();
      WeatherAlertCollectionMapper.ensureInitialized();
      SunTimesModelMapper.ensureInitialized();
      UnitSettingsMapper.ensureInitialized();
      AlertModelMapper.ensureInitialized();
      ErrorModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WeatherState';

  static WeatherStatus _$status(WeatherState v) => v.status;
  static const Field<WeatherState, WeatherStatus> _f$status =
      Field('status', _$status, opt: true, def: WeatherStatus.initial);
  static WeatherResponseModel? _$weatherModel(WeatherState v) => v.weatherModel;
  static const Field<WeatherState, WeatherResponseModel> _f$weatherModel =
      Field('weatherModel', _$weatherModel, opt: true);
  static Weather? _$weather(WeatherState v) => v.weather;
  static const Field<WeatherState, Weather> _f$weather =
      Field('weather', _$weather, opt: true);
  static WeatherAlertCollection? _$alerts(WeatherState v) => v.alerts;
  static const Field<WeatherState, WeatherAlertCollection> _f$alerts =
      Field('alerts', _$alerts, opt: true, def: const WeatherAlertCollection());
  static bool _$isDay(WeatherState v) => v.isDay;
  static const Field<WeatherState, bool> _f$isDay =
      Field('isDay', _$isDay, opt: true, def: true);
  static bool _$useBackupApi(WeatherState v) => v.useBackupApi;
  static const Field<WeatherState, bool> _f$useBackupApi =
      Field('useBackupApi', _$useBackupApi, opt: true, def: false);
  static bool _$searchIsLocal(WeatherState v) => v.searchIsLocal;
  static const Field<WeatherState, bool> _f$searchIsLocal =
      Field('searchIsLocal', _$searchIsLocal, opt: true, def: true);
  static List<SunTimesModel> _$refererenceSuntimes(WeatherState v) =>
      v.refererenceSuntimes;
  static const Field<WeatherState, List<SunTimesModel>> _f$refererenceSuntimes =
      Field('refererenceSuntimes', _$refererenceSuntimes,
          opt: true, def: const []);
  static UnitSettings _$unitSettings(WeatherState v) => v.unitSettings;
  static const Field<WeatherState, UnitSettings> _f$unitSettings = Field(
      'unitSettings', _$unitSettings,
      opt: true, def: const UnitSettings());
  static AlertModel _$alertModel(WeatherState v) => v.alertModel;
  static const Field<WeatherState, AlertModel> _f$alertModel = Field(
      'alertModel', _$alertModel,
      opt: true,
      def: const AlertModel(precipAlertType: PrecipNoticeType.noPrecip));
  static ErrorModel? _$errorModel(WeatherState v) => v.errorModel;
  static const Field<WeatherState, ErrorModel> _f$errorModel =
      Field('errorModel', _$errorModel, opt: true);

  @override
  final MappableFields<WeatherState> fields = const {
    #status: _f$status,
    #weatherModel: _f$weatherModel,
    #weather: _f$weather,
    #alerts: _f$alerts,
    #isDay: _f$isDay,
    #useBackupApi: _f$useBackupApi,
    #searchIsLocal: _f$searchIsLocal,
    #refererenceSuntimes: _f$refererenceSuntimes,
    #unitSettings: _f$unitSettings,
    #alertModel: _f$alertModel,
    #errorModel: _f$errorModel,
  };

  static WeatherState _instantiate(DecodingData data) {
    return WeatherState(
        status: data.dec(_f$status),
        weatherModel: data.dec(_f$weatherModel),
        weather: data.dec(_f$weather),
        alerts: data.dec(_f$alerts),
        isDay: data.dec(_f$isDay),
        useBackupApi: data.dec(_f$useBackupApi),
        searchIsLocal: data.dec(_f$searchIsLocal),
        refererenceSuntimes: data.dec(_f$refererenceSuntimes),
        unitSettings: data.dec(_f$unitSettings),
        alertModel: data.dec(_f$alertModel),
        errorModel: data.dec(_f$errorModel));
  }

  @override
  final Function instantiate = _instantiate;

  static WeatherState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WeatherState>(map);
  }

  static WeatherState fromJson(String json) {
    return ensureInitialized().decodeJson<WeatherState>(json);
  }
}

mixin WeatherStateMappable {
  String toJson() {
    return WeatherStateMapper.ensureInitialized()
        .encodeJson<WeatherState>(this as WeatherState);
  }

  Map<String, dynamic> toMap() {
    return WeatherStateMapper.ensureInitialized()
        .encodeMap<WeatherState>(this as WeatherState);
  }

  WeatherStateCopyWith<WeatherState, WeatherState, WeatherState> get copyWith =>
      _WeatherStateCopyWithImpl(this as WeatherState, $identity, $identity);
  @override
  String toString() {
    return WeatherStateMapper.ensureInitialized()
        .stringifyValue(this as WeatherState);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            WeatherStateMapper.ensureInitialized()
                .isValueEqual(this as WeatherState, other));
  }

  @override
  int get hashCode {
    return WeatherStateMapper.ensureInitialized()
        .hashValue(this as WeatherState);
  }
}

extension WeatherStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WeatherState, $Out> {
  WeatherStateCopyWith<$R, WeatherState, $Out> get $asWeatherState =>
      $base.as((v, t, t2) => _WeatherStateCopyWithImpl(v, t, t2));
}

abstract class WeatherStateCopyWith<$R, $In extends WeatherState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WeatherResponseModelCopyWith<$R, WeatherResponseModel, WeatherResponseModel>?
      get weatherModel;
  WeatherCopyWith<$R, Weather, Weather>? get weather;
  WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection,
      WeatherAlertCollection>? get alerts;
  ListCopyWith<$R, SunTimesModel,
          SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel>>
      get refererenceSuntimes;
  UnitSettingsCopyWith<$R, UnitSettings, UnitSettings> get unitSettings;
  AlertModelCopyWith<$R, AlertModel, AlertModel> get alertModel;
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get errorModel;
  $R call(
      {WeatherStatus? status,
      WeatherResponseModel? weatherModel,
      Weather? weather,
      WeatherAlertCollection? alerts,
      bool? isDay,
      bool? useBackupApi,
      bool? searchIsLocal,
      List<SunTimesModel>? refererenceSuntimes,
      UnitSettings? unitSettings,
      AlertModel? alertModel,
      ErrorModel? errorModel});
  WeatherStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WeatherStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WeatherState, $Out>
    implements WeatherStateCopyWith<$R, WeatherState, $Out> {
  _WeatherStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WeatherState> $mapper =
      WeatherStateMapper.ensureInitialized();
  @override
  WeatherResponseModelCopyWith<$R, WeatherResponseModel, WeatherResponseModel>?
      get weatherModel =>
          $value.weatherModel?.copyWith.$chain((v) => call(weatherModel: v));
  @override
  WeatherCopyWith<$R, Weather, Weather>? get weather =>
      $value.weather?.copyWith.$chain((v) => call(weather: v));
  @override
  WeatherAlertCollectionCopyWith<$R, WeatherAlertCollection,
          WeatherAlertCollection>?
      get alerts => $value.alerts?.copyWith.$chain((v) => call(alerts: v));
  @override
  ListCopyWith<$R, SunTimesModel,
          SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel>>
      get refererenceSuntimes => ListCopyWith($value.refererenceSuntimes,
          (v, t) => v.copyWith.$chain(t), (v) => call(refererenceSuntimes: v));
  @override
  UnitSettingsCopyWith<$R, UnitSettings, UnitSettings> get unitSettings =>
      $value.unitSettings.copyWith.$chain((v) => call(unitSettings: v));
  @override
  AlertModelCopyWith<$R, AlertModel, AlertModel> get alertModel =>
      $value.alertModel.copyWith.$chain((v) => call(alertModel: v));
  @override
  ErrorModelCopyWith<$R, ErrorModel, ErrorModel>? get errorModel =>
      $value.errorModel?.copyWith.$chain((v) => call(errorModel: v));
  @override
  $R call(
          {WeatherStatus? status,
          Object? weatherModel = $none,
          Object? weather = $none,
          Object? alerts = $none,
          bool? isDay,
          bool? useBackupApi,
          bool? searchIsLocal,
          List<SunTimesModel>? refererenceSuntimes,
          UnitSettings? unitSettings,
          AlertModel? alertModel,
          Object? errorModel = $none}) =>
      $apply(FieldCopyWithData({
        if (status != null) #status: status,
        if (weatherModel != $none) #weatherModel: weatherModel,
        if (weather != $none) #weather: weather,
        if (alerts != $none) #alerts: alerts,
        if (isDay != null) #isDay: isDay,
        if (useBackupApi != null) #useBackupApi: useBackupApi,
        if (searchIsLocal != null) #searchIsLocal: searchIsLocal,
        if (refererenceSuntimes != null)
          #refererenceSuntimes: refererenceSuntimes,
        if (unitSettings != null) #unitSettings: unitSettings,
        if (alertModel != null) #alertModel: alertModel,
        if (errorModel != $none) #errorModel: errorModel
      }));
  @override
  WeatherState $make(CopyWithData data) => WeatherState(
      status: data.get(#status, or: $value.status),
      weatherModel: data.get(#weatherModel, or: $value.weatherModel),
      weather: data.get(#weather, or: $value.weather),
      alerts: data.get(#alerts, or: $value.alerts),
      isDay: data.get(#isDay, or: $value.isDay),
      useBackupApi: data.get(#useBackupApi, or: $value.useBackupApi),
      searchIsLocal: data.get(#searchIsLocal, or: $value.searchIsLocal),
      refererenceSuntimes:
          data.get(#refererenceSuntimes, or: $value.refererenceSuntimes),
      unitSettings: data.get(#unitSettings, or: $value.unitSettings),
      alertModel: data.get(#alertModel, or: $value.alertModel),
      errorModel: data.get(#errorModel, or: $value.errorModel));

  @override
  WeatherStateCopyWith<$R2, WeatherState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WeatherStateCopyWithImpl($value, $cast, t);
}
