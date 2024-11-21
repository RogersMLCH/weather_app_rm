import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_rm/bloc/weather_bloc_bloc.dart';
import 'package:weather_app_rm/screens/home_screen.dart';

// Principal de la clase
void main() {
  runApp(const MyApp());
}

// Definición de la clase MyApp que extiende StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    // Método build que retorna el widget principal de la aplicación.
  Widget build(BuildContext context) {
    return MaterialApp(
        // Título de la aplicación.
        title: 'Weather App RM',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          // Llama a la función _determinePosition que obtiene la posición del usuario.
          future: _determinePosition(),
           // Constructor que construye el widget basado en el estado del Future.
          builder: (context,snap)
          {
            // Si el Future contiene datos (la posición del usuario).
            if(snap.hasData)
            {
              return BlocProvider<WeatherBlocBloc>(
          // Proveedor de Bloc para la gestión del estado de la aplicación del clima.
          create: (context) => WeatherBlocBloc()..add(FechWeather(snap.data as Position)),
          // Crea una instancia de WeatherBlocBloc y agrega un evento para obtener el clima basado en la posición.
          child: const HomeScreen() // Muestra la pantalla principal de la aplicación (Home Screen).
              );
            }else
            {
              // Imprime un mensaje de error en caso de que no haya datos.
              print('Error');
              return const Scaffold(
                // Muestra una pantalla de carga mientras se obtiene la posición.
                body: Center(
                  // Indicador de progreso circular.
                  child: CircularProgressIndicator(),
                ),
                
              );
            }
            }
            )
        );
      }
      }
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}