// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'daily_scroll_widget_model.dart';

class DailyScrollWidgetModelMapper
    extends ClassMapperBase<DailyScrollWidgetModel> {
  DailyScrollWidgetModelMapper._();

  static DailyScrollWidgetModelMapper? _instance;
  static DailyScrollWidgetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DailyScrollWidgetModelMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'DailyScrollWidgetModel';

  static String _$header(DailyScrollWidgetModel v) => v.header;
  static const Field<DailyScrollWidgetModel, String> _f$header =
      Field('header', _$header);
  static String _$iconPath(DailyScrollWidgetModel v) => v.iconPath;
  static const Field<DailyScrollWidgetModel, String> _f$iconPath =
      Field('iconPath', _$iconPath);
  static String _$month(DailyScrollWidgetModel v) => v.month;
  static const Field<DailyScrollWidgetModel, String> _f$month =
      Field('month', _$month);
  static String _$date(DailyScrollWidgetModel v) => v.date;
  static const Field<DailyScrollWidgetModel, String> _f$date =
      Field('date', _$date);
  static int _$temp(DailyScrollWidgetModel v) => v.temp;
  static const Field<DailyScrollWidgetModel, int> _f$temp =
      Field('temp', _$temp);
  static String _$precipitation(DailyScrollWidgetModel v) => v.precipitation;
  static const Field<DailyScrollWidgetModel, String> _f$precipitation =
      Field('precipitation', _$precipitation);
  static int _$index(DailyScrollWidgetModel v) => v.index;
  static const Field<DailyScrollWidgetModel, int> _f$index =
      Field('index', _$index);
  static int? _$lowTemp(DailyScrollWidgetModel v) => v.lowTemp;
  static const Field<DailyScrollWidgetModel, int> _f$lowTemp =
      Field('lowTemp', _$lowTemp);
  static int? _$highTemp(DailyScrollWidgetModel v) => v.highTemp;
  static const Field<DailyScrollWidgetModel, int> _f$highTemp =
      Field('highTemp', _$highTemp);

  @override
  final Map<Symbol, Field<DailyScrollWidgetModel, dynamic>> fields = const {
    #header: _f$header,
    #iconPath: _f$iconPath,
    #month: _f$month,
    #date: _f$date,
    #temp: _f$temp,
    #precipitation: _f$precipitation,
    #index: _f$index,
    #lowTemp: _f$lowTemp,
    #highTemp: _f$highTemp,
  };

  static DailyScrollWidgetModel _instantiate(DecodingData data) {
    return DailyScrollWidgetModel(
        header: data.dec(_f$header),
        iconPath: data.dec(_f$iconPath),
        month: data.dec(_f$month),
        date: data.dec(_f$date),
        temp: data.dec(_f$temp),
        precipitation: data.dec(_f$precipitation),
        index: data.dec(_f$index),
        lowTemp: data.dec(_f$lowTemp),
        highTemp: data.dec(_f$highTemp));
  }

  @override
  final Function instantiate = _instantiate;

  static DailyScrollWidgetModel fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<DailyScrollWidgetModel>(map));
  }

  static DailyScrollWidgetModel fromJson(String json) {
    return _guard((c) => c.fromJson<DailyScrollWidgetModel>(json));
  }
}

mixin DailyScrollWidgetModelMappable {
  String toJson() {
    return DailyScrollWidgetModelMapper._guard(
        (c) => c.toJson(this as DailyScrollWidgetModel));
  }

  Map<String, dynamic> toMap() {
    return DailyScrollWidgetModelMapper._guard(
        (c) => c.toMap(this as DailyScrollWidgetModel));
  }

  DailyScrollWidgetModelCopyWith<DailyScrollWidgetModel, DailyScrollWidgetModel,
          DailyScrollWidgetModel>
      get copyWith => _DailyScrollWidgetModelCopyWithImpl(
          this as DailyScrollWidgetModel, $identity, $identity);
  @override
  String toString() {
    return DailyScrollWidgetModelMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            DailyScrollWidgetModelMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return DailyScrollWidgetModelMapper._guard((c) => c.hash(this));
  }
}

extension DailyScrollWidgetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DailyScrollWidgetModel, $Out> {
  DailyScrollWidgetModelCopyWith<$R, DailyScrollWidgetModel, $Out>
      get $asDailyScrollWidgetModel =>
          $base.as((v, t, t2) => _DailyScrollWidgetModelCopyWithImpl(v, t, t2));
}

abstract class DailyScrollWidgetModelCopyWith<
    $R,
    $In extends DailyScrollWidgetModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? header,
      String? iconPath,
      String? month,
      String? date,
      int? temp,
      String? precipitation,
      int? index,
      int? lowTemp,
      int? highTemp});
  DailyScrollWidgetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DailyScrollWidgetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DailyScrollWidgetModel, $Out>
    implements
        DailyScrollWidgetModelCopyWith<$R, DailyScrollWidgetModel, $Out> {
  _DailyScrollWidgetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DailyScrollWidgetModel> $mapper =
      DailyScrollWidgetModelMapper.ensureInitialized();
  @override
  $R call(
          {String? header,
          String? iconPath,
          String? month,
          String? date,
          int? temp,
          String? precipitation,
          int? index,
          Object? lowTemp = $none,
          Object? highTemp = $none}) =>
      $apply(FieldCopyWithData({
        if (header != null) #header: header,
        if (iconPath != null) #iconPath: iconPath,
        if (month != null) #month: month,
        if (date != null) #date: date,
        if (temp != null) #temp: temp,
        if (precipitation != null) #precipitation: precipitation,
        if (index != null) #index: index,
        if (lowTemp != $none) #lowTemp: lowTemp,
        if (highTemp != $none) #highTemp: highTemp
      }));
  @override
  DailyScrollWidgetModel $make(CopyWithData data) => DailyScrollWidgetModel(
      header: data.get(#header, or: $value.header),
      iconPath: data.get(#iconPath, or: $value.iconPath),
      month: data.get(#month, or: $value.month),
      date: data.get(#date, or: $value.date),
      temp: data.get(#temp, or: $value.temp),
      precipitation: data.get(#precipitation, or: $value.precipitation),
      index: data.get(#index, or: $value.index),
      lowTemp: data.get(#lowTemp, or: $value.lowTemp),
      highTemp: data.get(#highTemp, or: $value.highTemp));

  @override
  DailyScrollWidgetModelCopyWith<$R2, DailyScrollWidgetModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DailyScrollWidgetModelCopyWithImpl($value, $cast, t);
}
