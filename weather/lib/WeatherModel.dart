// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class WeatherModel {
  final temp;
  final pressure;
  final humidity;
  final temp_max;
  final temp_min;
  final cityName;
  final wind;
  final sunrise;
  final sunset;
  final String icon;
  final String description;

  double get getTemp => temp - 272.5;
  double get getMaxTemp => temp_max - 272.5;
  double get getMinTemp => temp_min - 272.5;

  WeatherModel(
    this.temp,
    this.pressure,
    this.humidity,
    this.temp_max,
    this.temp_min,
    this.cityName,
    this.wind,
    this.sunrise,
    this.sunset,
    this.icon,
    this.description,
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      json["main"]["temp"],
      json["main"]["pressure"],
      json["main"]["humidity"],
      json["main"]["temp_min"],
      json["main"]["temp_max"],
      json["name"],
      json["wind"]["speed"],
      json["sys"]["sunrise"],
      json["sys"]["sunset"],
      json["icon"] as String,
      json["description"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "temp_max": temp_max,
        "temp_min": temp_min,
        "cityName": cityName,
        "wind": wind,
        "sunrise": sunrise,
        "sunset": sunset,
        "icon": icon,
        "description": description,
      };
}
