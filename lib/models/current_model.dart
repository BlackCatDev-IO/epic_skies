

import 'weather_condition_model.dart';

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  int dt;
  int sunrise;
  int sunset;
  double temp;
  double feelsLike;
  int pressure;
  int humidity;
  double dewPoint;
  double uvi;
  int clouds;
  int visibility;
  double windSpeed;
  int windDeg;
  double windGust;
  List<WeatherCondition> weather;
  // TODO Fix this type casting error without using dynamic
  dynamic pop;

  factory Current.fromJson(Map<String, dynamic> json) {
    final timeCode = json["dt"];
    final formattedTime =
        DateTime.fromMillisecondsSinceEpoch(timeCode * 1000).toString();
    final hour = DateTime.parse(formattedTime).hour;
    return Current(
      dt: hour,
      sunrise: json["sunrise"] == null ? null : json["sunrise"],
      sunset: json["sunset"] == null ? null : json["sunset"],
      temp: json["temp"].toDouble(),
      feelsLike: json["feels_like"].toDouble(),
      pressure: json["pressure"],
      humidity: json["humidity"],
      dewPoint: json["dew_point"].toDouble(),
      uvi: json["uvi"].toDouble(),
      clouds: json["clouds"],
      visibility: json["visibility"],
      windSpeed: json["wind_speed"].toDouble(),
      windDeg: json["wind_deg"],
      windGust: json["wind_gust"] == null ? null : json["wind_gust"].toDouble(),
      weather: List<WeatherCondition>.from(
          json["weather"].map((x) => WeatherCondition.fromJson(x))),
      pop: json["pop"] == null ? null : json["pop"] ,
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise == null ? null : sunrise,
        "sunset": sunset == null ? null : sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust == null ? null : windGust,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "pop": pop == null ? null : pop,
      };
}
