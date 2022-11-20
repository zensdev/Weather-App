// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, unused_import

import 'package:flutter/material.dart';
import '../api/WeatherModel.dart';
import '../service/sunset_sunrise_format.dart';

class AdditionalWeather extends StatelessWidget {
  WeatherModel weather;
  AdditionalWeather(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //Main title
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Text(weather.cityName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.w600,
                      height: 2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                alignment: Alignment.topLeft,
                child: Text(weather.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          //tempArea

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/icons/${weather.icon}@2x.png",
                    width: 100,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: weather.getTemp.round().toString() + "°",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 35,
              ),
              //currentWeatherMoreDetailsWidget

              Column(
                //wind and humidity
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(204, 223, 223, 223),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Image.asset("assets/icons/wind.png"),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(204, 223, 223, 223),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Image.asset("assets/icons/humidity.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: Text(
                          weather.wind.toString() + "km/h",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: Text(
                          weather.humidity.toString() + " %",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //resilience
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(204, 223, 223, 223),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Image.asset("assets/icons/resilience.png"),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(204, 223, 223, 223),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Image.asset("assets/icons/clouds.png"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: Text(
                          weather.pressure.toString() + " hPa",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 100,
                        child: Text(
                          weather.clouds.toString() + " %",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
