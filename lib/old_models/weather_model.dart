import 'dart:convert';

import 'current_model.dart';
import 'daily_model.dart';
import 'minutely_model.dart';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
    // this.alerts,
  });

  double lat;
  double lon;
  String timezone;
  int timezoneOffset;
  Current current;
  List<Minutely> minutely;
  List<Current> hourly;
  List<Daily> daily;
  // List<Alert> alerts;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        // minutely: List<Minutely>.from(json["minutely"].map((x) => Minutely.fromJson(x))),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
        // alerts: List<Alert>.from(json["alerts"].map((x) => Alert.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        // "minutely": List<dynamic>.from(minutely.map((x) => x.toJson())),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
        "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
        // "alerts": List<dynamic>.from(alerts.map((x) => x.toJson())),
      };
}

enum Main { CLEAR, CLOUDS, SNOW, RAIN }

final mainValues = EnumValues({
  "Clear": Main.CLEAR,
  "Clouds": Main.CLOUDS,
  "Rain": Main.RAIN,
  "Snow": Main.SNOW
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
