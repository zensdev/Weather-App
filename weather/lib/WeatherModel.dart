// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class WeatherModel {
  final double temp;
  final double pressure;
  final double humidity;
  final double temp_max;
  final double temp_min;
  final String cityName;
  final double wind;
  final int sunrise;
  final int sunset;
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
      json["main"]["temp"].toDouble(),
      json["main"]["pressure"].toDouble(),
      json["main"]["humidity"].toDouble(),
      json["main"]["temp_min"].toDouble(),
      json["main"]["temp_max"].toDouble(),
      json["name"].toString(),
      json["wind"]["speed"].toDouble(),
      json["sys"]["sunrise"].toInt(),
      json["sys"]["sunset"].toInt(),
      json["weather"][0]["icon"].toString(),
      json["weather"][0]["description"].toString(),
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "temp": temp,
  //       "pressure": pressure,
  //       "humidity": humidity,
  //       "temp_max": temp_max,
  //       "temp_min": temp_min,
  //       "cityName": cityName,
  //       "wind": wind,
  //       "sunrise": sunrise,
  //       "sunset": sunset,
  //       "icon": icon,
  //       "description": description,
  //     };
}
