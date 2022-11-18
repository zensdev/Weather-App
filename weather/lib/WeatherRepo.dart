// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

// class WeatherRepo {
//   Future<WeatherModel>? getWeather(String city) async {
//     var endpoint = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2&lang=vi");

//     var resposne = await http.get(endpoint);
//     var body = jsonDecode(resposne.body);
//     return WeatherModel.fromJson(body);
//   }
// }

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    final endpoint = await http.Client().get(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2&lang=vi");

    if (endpoint.statusCode != 200) throw Exception();

    return parsedJson(endpoint.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    //final jsonWeather = jsonDecoded[response.body];

    return WeatherModel.fromJson(jsonDecoded);
  }
}
