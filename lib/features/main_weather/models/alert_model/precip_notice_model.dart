import 'package:dart_mappable/dart_mappable.dart';

part 'precip_notice_model.mapper.dart';

@MappableEnum()
enum PrecipNoticeType {
  noPrecip,
  currentPrecip,
  forecastedPrecip;

  bool get isNoPrecip => this == PrecipNoticeType.noPrecip;
  bool get isCurrentPrecip => this == PrecipNoticeType.currentPrecip;
  bool get isForecastedPrecip => this == PrecipNoticeType.forecastedPrecip;
}

@MappableClass()
class PrecipNoticeModel with PrecipNoticeModelMappable {
  const PrecipNoticeModel({
    required this.precipAlertType,
    required this.precipNoticeIconPath,
    required this.precipNoticeMessage,
  });

  const PrecipNoticeModel.noPrecip()
      : precipAlertType = PrecipNoticeType.noPrecip,
        precipNoticeIconPath = '',
        precipNoticeMessage = '';

  final PrecipNoticeType precipAlertType;
  final String precipNoticeIconPath;
  final String precipNoticeMessage;
}
