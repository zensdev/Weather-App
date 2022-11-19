//! RUN:  flutter run --no-sound-null-safety

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, must_be_immutable, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'WeatherBloc.dart';
import 'WeatherModel.dart';
import 'WeatherRepo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'GoogleSans',
          backgroundColor: Colors.white),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => WeatherBloc(
            WeatherRepo(),
          ),
          child: SearchPage(),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherIsNotSearched) {
              return Container(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Tìm kiếm thời tiết",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.green,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Tên thành phố",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(
                                color: Colors.green,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          weatherBloc.add(
                            FetchWeather(cityController.text),
                          );
                        },
                        child: Text(
                          "Tìm kiếm",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is WeatherIsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherIsLoaded) {
              return ShowWeather(state.getWeather, cityController.text);
            } else {
              return Text(
                "Error",
                style: TextStyle(color: Colors.white),
              );
            }
          },
        )
      ],
    );
  }
}

class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          Text(
            weather.cityName,
            style: TextStyle(
                color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Image.asset(
            "assets/icons/${weather.icon}@2x.png",
            width: 200,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.getTemp.round().toString() + "°",
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
          Text(
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
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Text(
                    "Nhiệt độ thấp nhất",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    weather.getMaxTemp.round().toString() + "°",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  Text(
                    "Nhiệt độ cao nhất",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(
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
              child: Text(
                "Chi tiết",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(
                      color: Colors.green,
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
              child: Text(
                "Tìm kiếm",
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdditionalWeather extends StatelessWidget {
  WeatherModel weather;
  AdditionalWeather(this.weather);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Text(weather.cityName,
                    style: TextStyle(
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
          SizedBox(
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

              SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
