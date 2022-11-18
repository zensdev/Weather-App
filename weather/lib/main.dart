//! RUN:  flutter run --no-sound-null-safety

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, must_be_immutable, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'WeatherBloc.dart';
import 'WeatherModel.dart';
import 'WeatherRepo.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
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
                                color: Colors.blue,
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
                          style: TextStyle(color: Colors.blue, fontSize: 18),
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
            height: 15,
          ),
          Icon(
            Icons.sunny,
            color: Colors.orange,
            size: 100,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            weather.getTemp.round().toString() + "°C",
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
                    weather.getMinTemp.round().toString() + "°C",
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
                    weather.getMaxTemp.round().toString() + "°C",
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
              child: Text(
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

class AdditionalWeather extends StatelessWidget {
  WeatherModel additionalWeather;
  AdditionalWeather(this.additionalWeather);

  getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // getSunset() {
  //   DateTime.fromMillisecondsSinceEpoch(additionalWeather.sunset * 1000);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Text(additionalWeather.cityName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      height: 2,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                alignment: Alignment.topLeft,
                child: Text(getCurrentDate(),
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
                children: [
                  Text(additionalWeather.icon)
                  // Image.asset(
                  //   "assets/icons/${additionalWeather.icon}.png",
                  // )
                ],
              )
              //currentWeatherMoreDetailsWidget
            ],
          ),
        ],
      )),
    );
  }
}
