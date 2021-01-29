

class Minutely {
    Minutely({
        this.dt,
        this.precipitation,
    });

    int dt;
    int precipitation;

    factory Minutely.fromJson(Map<String, dynamic> json) => Minutely(
        dt: json["dt"],
        precipitation: json["precipitation"],
    );

    Map<String, dynamic> toJson() => {
        "dt": dt,
        "precipitation": precipitation,
    };
}
