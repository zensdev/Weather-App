//! RUN:  flutter run --no-sound-null-safety

// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'service/WeatherBloc.dart';
import 'api/WeatherRepo.dart';
import 'screens/search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          child: const SearchPage(),
        ),
      ),
    );
  }
}
