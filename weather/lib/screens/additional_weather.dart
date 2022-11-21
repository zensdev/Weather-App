// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/animation/fade_animation.dart';
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
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: FadeAnimation(
                  delay: 0,
                  child: Text(
                    weather.cityName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 55,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                alignment: Alignment.topLeft,
                child: FadeAnimation(
                  delay: 0.2,
                  child: Text(
                    weather.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //tempArea

          Column(
            children: [
              //main temp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: FadeAnimation(
                      delay: 0.5,
                      child: Container(
                        height: 170,
                        width: 350,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(204, 145, 145, 145),
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //icon
                                SizedBox(
                                  width: 120,
                                  child: FadeAnimation(
                                    delay: 0.7,
                                    child: Image.asset(
                                      "assets/icons/${weather.icon}@2x.png",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            //temp
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: FadeAnimation(
                                    delay: 0.9,
                                    child: Text(
                                      weather.getTemp.round().toString() + "°C",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 60,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //currentWeatherMoreDetailsWidget

              Column(
                children: [
                  //wind and humidity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: FadeAnimation(
                          delay: 1,
                          child: Container(
                            height: 140,
                            width: 350,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(204, 145, 145, 145),
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //humidity
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.1,
                                        child: const Text("Độ ẩm không khí"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: FadeAnimation(
                                        delay: 1.2,
                                        child: Image.asset(
                                          "assets/icons/humidity.png",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.3,
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
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                //wind
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.3,
                                        child: const Text("Tốc độ gió"),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 60,
                                        child: FadeAnimation(
                                          delay: 1.4,
                                          child: Image.asset(
                                            "assets/icons/wind.png",
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.5,
                                        child: Text(
                                          weather.wind.toString() + " km/h",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //resilience & clouds
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: FadeAnimation(
                          delay: 1.6,
                          child: Container(
                            height: 140,
                            width: 350,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(204, 145, 145, 145),
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //resilience
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.6,
                                        child: const Text("Áp suất không khí"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: FadeAnimation(
                                        delay: 1.7,
                                        child: Image.asset(
                                          "assets/icons/resilience.png",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.8,
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
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                //clouds
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 1.8,
                                        child: const Text("Mây"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: FadeAnimation(
                                        delay: 1.9,
                                        child: Image.asset(
                                          "assets/icons/clouds.png",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 2,
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
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //sunset & sunrise
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: FadeAnimation(
                          delay: 2.1,
                          child: Container(
                            height: 140,
                            width: 350,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(204, 145, 145, 145),
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //sunrise
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 2.1,
                                        child: const Text("Bình minh"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: FadeAnimation(
                                        delay: 2.2,
                                        child: Image.asset(
                                          "assets/icons/sunrise.png",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 2.3,
                                        child: Text(
                                          readSunrise(weather.sunrise),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //sunset
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 2.3,
                                        child: const Text("Hoàng hôn"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: FadeAnimation(
                                        delay: 2.4,
                                        child: Image.asset(
                                          "assets/icons/sunset.png",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      child: FadeAnimation(
                                        delay: 2.5,
                                        child: Text(
                                          readSunset(weather.sunset),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
