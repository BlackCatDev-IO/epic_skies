class SunTimesModel {
  String sunsetString, sunriseString;
  DateTime? sunriseTime, sunsetTime;

  SunTimesModel(
      {required this.sunsetString,
      required this.sunriseString,
      this.sunriseTime,
      this.sunsetTime});

  SunTimesModel.fromMap(Map<String, dynamic> map)
      : sunriseString = map['sunriseString'] as String,
        sunsetString = map['sunsetString'] as String,
        sunriseTime = DateTime.parse(map['sunriseTime'] as String),
        sunsetTime = DateTime.parse(map['sunsetTime'] as String);

  Map<String, dynamic> toMap() {
    return {
      'sunriseString': sunriseString,
      'sunsetString': sunsetString,
      'sunriseTime': sunriseTime.toString(),
      'sunsetTime': sunsetTime.toString(),
    };
  }

  @override
  String toString() {
    final sunTimeString =
        'sunriseString: $sunriseString sunsetString:$sunsetString';

    if (sunriseTime != null && sunsetTime != null) {
      return '$sunTimeString sunrise: $sunriseTime sunset: $sunsetTime';
    } else {
      return sunTimeString;
    }
  }
}
