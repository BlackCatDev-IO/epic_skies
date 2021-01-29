
class FeelsLike {
    FeelsLike({
        this.day,
        this.night,
        this.eve,
        this.morn,
    });

    double day;
    double night;
    double eve;
    double morn;

    factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
    };
}
