// ignore_for_file: avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/animation/fade_animation.dart';
import 'package:weather/screens/search_page.dart';
import 'package:weather/service/WeatherBloc.dart';

class Error extends StatefulWidget {
  const Error({super.key});

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: FadeAnimation(
              delay: 0,
              child: Image.asset(
                "assets/icons/error.png",
                width: 300,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 300,
            height: 50,
            child: FadeAnimation(
              delay: 0.2,
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
                  "Quay lại",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
