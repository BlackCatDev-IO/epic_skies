// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hourly_vertical_widget_model.dart';

class HourlyVerticalWidgetModelMapper
    extends ClassMapperBase<HourlyVerticalWidgetModel> {
  HourlyVerticalWidgetModelMapper._();

  static HourlyVerticalWidgetModelMapper? _instance;
  static HourlyVerticalWidgetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = HourlyVerticalWidgetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HourlyVerticalWidgetModel';

  static int _$temp(HourlyVerticalWidgetModel v) => v.temp;
  static const Field<HourlyVerticalWidgetModel, int> _f$temp =
      Field('temp', _$temp);
  static String _$iconPath(HourlyVerticalWidgetModel v) => v.iconPath;
  static const Field<HourlyVerticalWidgetModel, String> _f$iconPath =
      Field('iconPath', _$iconPath);
  static int _$precipitation(HourlyVerticalWidgetModel v) => v.precipitation;
  static const Field<HourlyVerticalWidgetModel, int> _f$precipitation =
      Field('precipitation', _$precipitation);
  static String _$time(HourlyVerticalWidgetModel v) => v.time;
  static const Field<HourlyVerticalWidgetModel, String> _f$time =
      Field('time', _$time);
  static String? _$suntimeString(HourlyVerticalWidgetModel v) =>
      v.suntimeString;
  static const Field<HourlyVerticalWidgetModel, String> _f$suntimeString =
      Field('suntimeString', _$suntimeString, opt: true);
  static bool? _$isSunrise(HourlyVerticalWidgetModel v) => v.isSunrise;
  static const Field<HourlyVerticalWidgetModel, bool> _f$isSunrise =
      Field('isSunrise', _$isSunrise, opt: true);

  @override
  final MappableFields<HourlyVerticalWidgetModel> fields = const {
    #temp: _f$temp,
    #iconPath: _f$iconPath,
    #precipitation: _f$precipitation,
    #time: _f$time,
    #suntimeString: _f$suntimeString,
    #isSunrise: _f$isSunrise,
  };

  static HourlyVerticalWidgetModel _instantiate(DecodingData data) {
    return HourlyVerticalWidgetModel(
        temp: data.dec(_f$temp),
        iconPath: data.dec(_f$iconPath),
        precipitation: data.dec(_f$precipitation),
        time: data.dec(_f$time),
        suntimeString: data.dec(_f$suntimeString),
        isSunrise: data.dec(_f$isSunrise));
  }

  @override
  final Function instantiate = _instantiate;

  static HourlyVerticalWidgetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HourlyVerticalWidgetModel>(map);
  }

  static HourlyVerticalWidgetModel fromJson(String json) {
    return ensureInitialized().decodeJson<HourlyVerticalWidgetModel>(json);
  }
}

mixin HourlyVerticalWidgetModelMappable {
  String toJson() {
    return HourlyVerticalWidgetModelMapper.ensureInitialized()
        .encodeJson<HourlyVerticalWidgetModel>(
            this as HourlyVerticalWidgetModel);
  }

  Map<String, dynamic> toMap() {
    return HourlyVerticalWidgetModelMapper.ensureInitialized()
        .encodeMap<HourlyVerticalWidgetModel>(
            this as HourlyVerticalWidgetModel);
  }

  HourlyVerticalWidgetModelCopyWith<HourlyVerticalWidgetModel,
          HourlyVerticalWidgetModel, HourlyVerticalWidgetModel>
      get copyWith => _HourlyVerticalWidgetModelCopyWithImpl(
          this as HourlyVerticalWidgetModel, $identity, $identity);
  @override
  String toString() {
    return HourlyVerticalWidgetModelMapper.ensureInitialized()
        .stringifyValue(this as HourlyVerticalWidgetModel);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            HourlyVerticalWidgetModelMapper.ensureInitialized()
                .isValueEqual(this as HourlyVerticalWidgetModel, other));
  }

  @override
  int get hashCode {
    return HourlyVerticalWidgetModelMapper.ensureInitialized()
        .hashValue(this as HourlyVerticalWidgetModel);
  }
}

extension HourlyVerticalWidgetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HourlyVerticalWidgetModel, $Out> {
  HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel, $Out>
      get $asHourlyVerticalWidgetModel => $base
          .as((v, t, t2) => _HourlyVerticalWidgetModelCopyWithImpl(v, t, t2));
}

abstract class HourlyVerticalWidgetModelCopyWith<
    $R,
    $In extends HourlyVerticalWidgetModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? temp,
      String? iconPath,
      int? precipitation,
      String? time,
      String? suntimeString,
      bool? isSunrise});
  HourlyVerticalWidgetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _HourlyVerticalWidgetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HourlyVerticalWidgetModel, $Out>
    implements
        HourlyVerticalWidgetModelCopyWith<$R, HourlyVerticalWidgetModel, $Out> {
  _HourlyVerticalWidgetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HourlyVerticalWidgetModel> $mapper =
      HourlyVerticalWidgetModelMapper.ensureInitialized();
  @override
  $R call(
          {int? temp,
          String? iconPath,
          int? precipitation,
          String? time,
          Object? suntimeString = $none,
          Object? isSunrise = $none}) =>
      $apply(FieldCopyWithData({
        if (temp != null) #temp: temp,
        if (iconPath != null) #iconPath: iconPath,
        if (precipitation != null) #precipitation: precipitation,
        if (time != null) #time: time,
        if (suntimeString != $none) #suntimeString: suntimeString,
        if (isSunrise != $none) #isSunrise: isSunrise
      }));
  @override
  HourlyVerticalWidgetModel $make(CopyWithData data) =>
      HourlyVerticalWidgetModel(
          temp: data.get(#temp, or: $value.temp),
          iconPath: data.get(#iconPath, or: $value.iconPath),
          precipitation: data.get(#precipitation, or: $value.precipitation),
          time: data.get(#time, or: $value.time),
          suntimeString: data.get(#suntimeString, or: $value.suntimeString),
          isSunrise: data.get(#isSunrise, or: $value.isSunrise));

  @override
  HourlyVerticalWidgetModelCopyWith<$R2, HourlyVerticalWidgetModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _HourlyVerticalWidgetModelCopyWithImpl($value, $cast, t);
}
