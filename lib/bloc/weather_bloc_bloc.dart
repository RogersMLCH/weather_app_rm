// Importaciones de paquetes
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
    // Constructor del Bloc, inicializa el estado con 'WeatherBlocInitial'.
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    // Define la reacción del Bloc a un evento de tipo 'FechWeather'.
    on<FechWeather>((event, emit) async{

      emit(WeatherBlocLoading());

      try
      {
      // Crea una instancia de 'WeatherFactory' usando una clave API y especificando el idioma.
      WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
      
      // Obtiene el clima actual basado en la latitud y longitud proporcionada en el evento.
      Weather weather = await  wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
      
      // Imprime la información del clima en la consola para depuración.
      print(weather);

      // Cambia el estado a 'WeatherBlocSucess' con los datos del clima obtenidos.
      emit(WeatherBlocSucess(weather));

      }catch(e){
        // Cambia el estado a 'WeatherBlocFailure' si ocurre un error al obtener el clima.
        emit(WeatherBlocFailure());
      }
    });
  }
}
