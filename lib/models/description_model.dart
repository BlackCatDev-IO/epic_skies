class WeatherCondition {
  WeatherCondition({
    this.id,
    this.main,
    this.description,
  });

  int id;
  String main;
  String description;

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      WeatherCondition(
        id: json["id"],
        main: json["main"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
      };
}
