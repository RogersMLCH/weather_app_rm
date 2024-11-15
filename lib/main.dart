import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_rm/screens/home_screen.dart';

//principal de la clase
void main() {
  runApp(const MyApp());
}

//la clase
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // Este es el Widget principla que llama al arhcivo con el home
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App RM',
        debugShowCheckedModeBanner: false,
        home: BlocProvider<WeatherBlocBloc>(
          create: (context) => WeatherBlocBloc()..add(FechWeather()),
          child: const HomeScreen(),
        )
        /*
      home: Scaffold(
        body: Center(
          child: Text("Hola"),
        ),
      ),
    */
        );
  }
}
