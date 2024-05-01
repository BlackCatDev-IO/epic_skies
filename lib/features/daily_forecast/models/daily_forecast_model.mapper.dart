// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'daily_forecast_model.dart';

class DailyForecastModelMapper extends ClassMapperBase<DailyForecastModel> {
  DailyForecastModelMapper._();

  static DailyForecastModelMapper? _instance;
  static DailyForecastModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyForecastModelMapper._());
      SunTimesModelMapper.ensureInitialized();
      HourlyForecastModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DailyForecastModel';

  static int _$dailyTemp(DailyForecastModel v) => v.dailyTemp;
  static const Field<DailyForecastModel, int> _f$dailyTemp =
      Field('dailyTemp', _$dailyTemp);
  static int _$feelsLikeDay(DailyForecastModel v) => v.feelsLikeDay;
  static const Field<DailyForecastModel, int> _f$feelsLikeDay =
      Field('feelsLikeDay', _$feelsLikeDay);
  static num _$precipitationAmount(DailyForecastModel v) =>
      v.precipitationAmount;
  static const Field<DailyForecastModel, num> _f$precipitationAmount =
      Field('precipitationAmount', _$precipitationAmount);
  static int _$windSpeed(DailyForecastModel v) => v.windSpeed;
  static const Field<DailyForecastModel, int> _f$windSpeed =
      Field('windSpeed', _$windSpeed);
  static num _$precipitationProbability(DailyForecastModel v) =>
      v.precipitationProbability;
  static const Field<DailyForecastModel, num> _f$precipitationProbability =
      Field('precipitationProbability', _$precipitationProbability);
  static String _$precipitationType(DailyForecastModel v) =>
      v.precipitationType;
  static const Field<DailyForecastModel, String> _f$precipitationType =
      Field('precipitationType', _$precipitationType);
  static String _$iconPath(DailyForecastModel v) => v.iconPath;
  static const Field<DailyForecastModel, String> _f$iconPath =
      Field('iconPath', _$iconPath);
  static String _$day(DailyForecastModel v) => v.day;
  static const Field<DailyForecastModel, String> _f$day = Field('day', _$day);
  static String _$month(DailyForecastModel v) => v.month;
  static const Field<DailyForecastModel, String> _f$month =
      Field('month', _$month);
  static String _$year(DailyForecastModel v) => v.year;
  static const Field<DailyForecastModel, String> _f$year =
      Field('year', _$year);
  static int _$date(DailyForecastModel v) => v.date;
  static const Field<DailyForecastModel, int> _f$date = Field('date', _$date);
  static String _$condition(DailyForecastModel v) => v.condition;
  static const Field<DailyForecastModel, String> _f$condition =
      Field('condition', _$condition);
  static SunTimesModel _$suntime(DailyForecastModel v) => v.suntime;
  static const Field<DailyForecastModel, SunTimesModel> _f$suntime =
      Field('suntime', _$suntime);
  static List<HourlyForecastModel> _$extendedHourlyList(DailyForecastModel v) =>
      v.extendedHourlyList;
  static const Field<DailyForecastModel, List<HourlyForecastModel>>
      _f$extendedHourlyList = Field('extendedHourlyList', _$extendedHourlyList);
  static int? _$highTemp(DailyForecastModel v) => v.highTemp;
  static const Field<DailyForecastModel, int> _f$highTemp =
      Field('highTemp', _$highTemp, opt: true);
  static int? _$lowTemp(DailyForecastModel v) => v.lowTemp;
  static const Field<DailyForecastModel, int> _f$lowTemp =
      Field('lowTemp', _$lowTemp, opt: true);
  static String? _$precipIconPath(DailyForecastModel v) => v.precipIconPath;
  static const Field<DailyForecastModel, String> _f$precipIconPath =
      Field('precipIconPath', _$precipIconPath, opt: true);

  @override
  final MappableFields<DailyForecastModel> fields = const {
    #dailyTemp: _f$dailyTemp,
    #feelsLikeDay: _f$feelsLikeDay,
    #precipitationAmount: _f$precipitationAmount,
    #windSpeed: _f$windSpeed,
    #precipitationProbability: _f$precipitationProbability,
    #precipitationType: _f$precipitationType,
    #iconPath: _f$iconPath,
    #day: _f$day,
    #month: _f$month,
    #year: _f$year,
    #date: _f$date,
    #condition: _f$condition,
    #suntime: _f$suntime,
    #extendedHourlyList: _f$extendedHourlyList,
    #highTemp: _f$highTemp,
    #lowTemp: _f$lowTemp,
    #precipIconPath: _f$precipIconPath,
  };

  static DailyForecastModel _instantiate(DecodingData data) {
    return DailyForecastModel(
        dailyTemp: data.dec(_f$dailyTemp),
        feelsLikeDay: data.dec(_f$feelsLikeDay),
        precipitationAmount: data.dec(_f$precipitationAmount),
        windSpeed: data.dec(_f$windSpeed),
        precipitationProbability: data.dec(_f$precipitationProbability),
        precipitationType: data.dec(_f$precipitationType),
        iconPath: data.dec(_f$iconPath),
        day: data.dec(_f$day),
        month: data.dec(_f$month),
        year: data.dec(_f$year),
        date: data.dec(_f$date),
        condition: data.dec(_f$condition),
        suntime: data.dec(_f$suntime),
        extendedHourlyList: data.dec(_f$extendedHourlyList),
        highTemp: data.dec(_f$highTemp),
        lowTemp: data.dec(_f$lowTemp),
        precipIconPath: data.dec(_f$precipIconPath));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyForecastModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DailyForecastModel>(map);
  }

  static DailyForecastModel fromJson(String json) {
    return ensureInitialized().decodeJson<DailyForecastModel>(json);
  }
}

mixin DailyForecastModelMappable {
  String toJson() {
    return DailyForecastModelMapper.ensureInitialized()
        .encodeJson<DailyForecastModel>(this as DailyForecastModel);
  }

  Map<String, dynamic> toMap() {
    return DailyForecastModelMapper.ensureInitialized()
        .encodeMap<DailyForecastModel>(this as DailyForecastModel);
  }

  DailyForecastModelCopyWith<DailyForecastModel, DailyForecastModel,
          DailyForecastModel>
      get copyWith => _DailyForecastModelCopyWithImpl(
          this as DailyForecastModel, $identity, $identity);
  @override
  String toString() {
    return DailyForecastModelMapper.ensureInitialized()
        .stringifyValue(this as DailyForecastModel);
  }

  @override
  bool operator ==(Object other) {
    return DailyForecastModelMapper.ensureInitialized()
        .equalsValue(this as DailyForecastModel, other);
  }

  @override
  int get hashCode {
    return DailyForecastModelMapper.ensureInitialized()
        .hashValue(this as DailyForecastModel);
  }
}

extension DailyForecastModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyForecastModel, $Out> {
  DailyForecastModelCopyWith<$R, DailyForecastModel, $Out>
      get $asDailyForecastModel =>
          $base.as((v, t, t2) => _DailyForecastModelCopyWithImpl(v, t, t2));
}

abstract class DailyForecastModelCopyWith<$R, $In extends DailyForecastModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel> get suntime;
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get extendedHourlyList;
  $R call(
      {int? dailyTemp,
      int? feelsLikeDay,
      num? precipitationAmount,
      int? windSpeed,
      num? precipitationProbability,
      String? precipitationType,
      String? iconPath,
      String? day,
      String? month,
      String? year,
      int? date,
      String? condition,
      SunTimesModel? suntime,
      List<HourlyForecastModel>? extendedHourlyList,
      int? highTemp,
      int? lowTemp,
      String? precipIconPath});
  DailyForecastModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DailyForecastModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyForecastModel, $Out>
    implements DailyForecastModelCopyWith<$R, DailyForecastModel, $Out> {
  _DailyForecastModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyForecastModel> $mapper =
      DailyForecastModelMapper.ensureInitialized();
  @override
  SunTimesModelCopyWith<$R, SunTimesModel, SunTimesModel> get suntime =>
      $value.suntime.copyWith.$chain((v) => call(suntime: v));
  @override
  ListCopyWith<
      $R,
      HourlyForecastModel,
      HourlyForecastModelCopyWith<$R, HourlyForecastModel,
          HourlyForecastModel>> get extendedHourlyList => ListCopyWith(
      $value.extendedHourlyList,
      (v, t) => v.copyWith.$chain(t),
      (v) => call(extendedHourlyList: v));
  @override
  $R call(
          {int? dailyTemp,
          int? feelsLikeDay,
          num? precipitationAmount,
          int? windSpeed,
          num? precipitationProbability,
          String? precipitationType,
          String? iconPath,
          String? day,
          String? month,
          String? year,
          int? date,
          String? condition,
          SunTimesModel? suntime,
          List<HourlyForecastModel>? extendedHourlyList,
          Object? highTemp = $none,
          Object? lowTemp = $none,
          Object? precipIconPath = $none}) =>
      $apply(FieldCopyWithData({
        if (dailyTemp != null) #dailyTemp: dailyTemp,
        if (feelsLikeDay != null) #feelsLikeDay: feelsLikeDay,
        if (precipitationAmount != null)
          #precipitationAmount: precipitationAmount,
        if (windSpeed != null) #windSpeed: windSpeed,
        if (precipitationProbability != null)
          #precipitationProbability: precipitationProbability,
        if (precipitationType != null) #precipitationType: precipitationType,
        if (iconPath != null) #iconPath: iconPath,
        if (day != null) #day: day,
        if (month != null) #month: month,
        if (year != null) #year: year,
        if (date != null) #date: date,
        if (condition != null) #condition: condition,
        if (suntime != null) #suntime: suntime,
        if (extendedHourlyList != null) #extendedHourlyList: extendedHourlyList,
        if (highTemp != $none) #highTemp: highTemp,
        if (lowTemp != $none) #lowTemp: lowTemp,
        if (precipIconPath != $none) #precipIconPath: precipIconPath
      }));
  @override
  DailyForecastModel $make(CopyWithData data) => DailyForecastModel(
      dailyTemp: data.get(#dailyTemp, or: $value.dailyTemp),
      feelsLikeDay: data.get(#feelsLikeDay, or: $value.feelsLikeDay),
      precipitationAmount:
          data.get(#precipitationAmount, or: $value.precipitationAmount),
      windSpeed: data.get(#windSpeed, or: $value.windSpeed),
      precipitationProbability: data.get(#precipitationProbability,
          or: $value.precipitationProbability),
      precipitationType:
          data.get(#precipitationType, or: $value.precipitationType),
      iconPath: data.get(#iconPath, or: $value.iconPath),
      day: data.get(#day, or: $value.day),
      month: data.get(#month, or: $value.month),
      year: data.get(#year, or: $value.year),
      date: data.get(#date, or: $value.date),
      condition: data.get(#condition, or: $value.condition),
      suntime: data.get(#suntime, or: $value.suntime),
      extendedHourlyList:
          data.get(#extendedHourlyList, or: $value.extendedHourlyList),
      highTemp: data.get(#highTemp, or: $value.highTemp),
      lowTemp: data.get(#lowTemp, or: $value.lowTemp),
      precipIconPath: data.get(#precipIconPath, or: $value.precipIconPath));

  @override
  DailyForecastModelCopyWith<$R2, DailyForecastModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DailyForecastModelCopyWithImpl($value, $cast, t);
}
