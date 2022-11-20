// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/main.dart';
import 'package:weather/screens/show_weather.dart';
import '../service/WeatherBloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Tìm kiếm thời tiết",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
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
                            color: Colors.blue,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Tên thành phố",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          weatherBloc.add(
                            FetchWeather(cityController.text),
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
            } else if (state is WeatherIsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherIsLoaded) {
              return ShowWeather(state.getWeather, cityController.text);
            } else {
              return const Text(
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
