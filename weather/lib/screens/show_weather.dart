// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/main.dart';
import '../service/WeatherBloc.dart';
import '../api/WeatherModel.dart';
import 'additional_weather.dart';

class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  ShowWeather(this.weather, this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          Text(
            weather.cityName,
            style: const TextStyle(
                color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            "assets/icons/${weather.icon}@2x.png",
            width: 200,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            weather.getTemp.round().toString() + "°",
            style: const TextStyle(color: Colors.black, fontSize: 50),
          ),
          const Text(
            "Nhiệt độ",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    weather.getMinTemp.round().toString() + "°",
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  const Text(
                    "Nhiệt độ thấp nhất",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    weather.getMaxTemp.round().toString() + "°",
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  const Text(
                    "Nhiệt độ cao nhất",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdditionalWeather(weather),
                  ),
                );
              },
              child: const Text(
                "Chi tiết",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(
                  ResetWeather(),
                );
              },
              child: const Text(
                "Tìm kiếm",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
