
import 'feels_like_model.dart';
import 'temp_model.dart';
import 'weather_condition_model.dart';

class Daily {
    Daily({
        this.dt,
        this.sunrise,
        this.sunset,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.windSpeed,
        this.windDeg,
        this.weather,
        this.clouds,
        this.pop,
        this.uvi,
        this.snow,
        this.rain,
    });

    int dt;
    int sunrise;
    int sunset;
    Temp temp;
    FeelsLike feelsLike;
    int pressure;
    int humidity;
    double dewPoint;
    double windSpeed;
    int windDeg;
    List<WeatherCondition> weather;
    int clouds;
    double pop;
    double uvi;
    double snow;
    double rain;

    factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: Temp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather: List<WeatherCondition>.from(json["weather"].map((x) => WeatherCondition.fromJson(x))),
        clouds: json["clouds"],
        pop: json["pop"].toDouble(),
        uvi: json["uvi"].toDouble(),
        snow: json["snow"] == null ? 0 : json["snow"].toDouble(),
        rain: json["rain"] == null ? 0 : json["rain"].toDouble(),
    );
    Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp.toJson(),
        "feels_like": feelsLike.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
        "pop": pop,
        "uvi": uvi,
        "snow": snow == null ? 0 : snow,
        "rain": rain == null ? 0 : rain,
    };
}